import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:obourkom_driver/features/main/data/repositories/main_repo.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({required this.mainRepository})
    : super(MainState(available: false));
  final MainRepository mainRepository;

  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? ordersStream;
  void listenForOrders() async {
    try {
      ordersStream?.cancel();
      emit(state.copyWith(getOrdersState: GetOrdersState.loading));
      ordersStream = mainRepository.listenForOrders().listen((data) {
        emit(
          state.copyWith(
            getOrdersState: GetOrdersState.success,
            ordersIds: data,
          ),
        );
      });
    } catch (e) {
      logger.e(e);
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getOrdersState: GetOrdersState.failure,
        ),
      );
    }
  }

  void cancelOrderStream() {
    logger.e(' ordersStream?.cancel();');
    ordersStream?.cancel();
  }

  void assignOrder(String order) {
    priceController.clear();
    emit(state.copyWith(order: order, sendOfferState: SendOfferState.init));
  }

  void sendOffer() async {
    try {
      emit(state.copyWith(sendOfferState: SendOfferState.loading));
      await mainRepository.sendOffer(
        price: priceController.text,
        orderId: state.order!,
      );
      listenForOfferAccept(state.order!);
      emit(state.copyWith(sendOfferState: SendOfferState.success));
    } on ApiException catch (e) {
      logger.e(e);
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          sendOfferState: SendOfferState.failure,
        ),
      );
    } catch (e) {
      logger.e(e);
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          sendOfferState: SendOfferState.failure,
        ),
      );
    }
  }

  StreamSubscription? driverIdStream;
  void listenForOfferAccept(String orderId) {
    try {
      driverIdStream = mainRepository.listenForDriverId(orderId).listen((
        acceptedId,
      ) {
        emit(state.copyWith(driverId: acceptedId));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void cancelListenForOrderAccept() {
    driverIdStream?.cancel();
  }

  void toggleSwitch(bool value) {
    if (value) {
      listenForOrders();
      emit(state.copyWith(available: true));
    } else {
      cancelOrderStream();
      emit(state.copyWith(available: false));
    }
  }

  @override
  Future<void> close() {
    driverIdStream?.cancel();
    priceController.dispose();
    return super.close();
  }
}
