import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_offer_model.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';
import 'package:obourkom_driver/features/main/data/repositories/main_repo.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({required this.mainRepository})
    : super(const MainState(available: true));
  final MainRepository mainRepository;

  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? ordersStream;
  void listenForOrders() async {
    try {
      logger.d(' ordersStream?.cancel();');
      ordersStream?.cancel();
      emit(state.copyWith(getOrdersState: GetOrdersState.loading));
      ordersStream = mainRepository.listenForOrders().listen(
        (data) {
          logger.d(data);
          emit(
            state.copyWith(
              getOrdersState: GetOrdersState.success,
              ordersIds: data,
            ),
          );
        },
        onError: (e) {
          logger.e(e);
          state.copyWith(
            errorMessage: e.toString(),
            getOrdersState: GetOrdersState.failure,
          );
        },
      );
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
    logger.d(' ordersStream?.cancel();');
    ordersStream?.cancel();
  }

  void sendOffer(String orderId) async {
    try {
      emit(state.copyWith(sendOfferState: SendOfferState.loading));
      final offerId = await mainRepository.sendOffer(
        price: priceController.text,
        orderId: orderId,
      );
      listenForMyOffer(orderId: orderId, offerId: offerId.toString());
      emit(state.copyWith(sendOfferState: SendOfferState.success));
    } on ApiException catch (e) {
      logger.e(e.failure.message);
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

  StreamSubscription? offerStream;
  void listenForMyOffer({required String orderId, required String offerId}) {
    try {
      offerStream?.cancel();
      offerStream = mainRepository
          .listenForMyOffer(orderId, offerId)
          .listen(
            (data) {
              if (data.status == 'cancelled' || data.isAccepted == true) {
                offerStream?.cancel();
              }
              emit(state.copyWith(offer: data));
            },
            onError: (e) {
              state.copyWith(errorMessage: e.toString());
            },
          );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
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
    priceController.dispose();
    cancelOrderStream();
    offerStream?.cancel();
    return super.close();
  }
}
