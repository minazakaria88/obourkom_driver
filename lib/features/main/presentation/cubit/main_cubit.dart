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
  MainCubit({required this.mainRepository}) : super(MainState(available: true));
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
    emit(
      state.copyWith(
        order: order,
        sendOfferState: SendOfferState.init,
        driverId: '',
        offer: FirebaseOfferModel(

        ),
      ),
    );
  }

  void sendOffer() async {
    try {
      emit(state.copyWith(sendOfferState: SendOfferState.loading));
    final offerId =  await mainRepository.sendOffer(
        price: priceController.text,
        orderId: state.order!,
      );
      //listenForOfferAccept(state.order!);
      listenForMyOffer(
        orderId: state.order!,
        offerId: offerId.toString(),
      );
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

  // StreamSubscription? driverIdStream;
  // void listenForOfferAccept(String orderId) {
  //   try {
  //     driverIdStream = mainRepository.listenForDriverId(orderId).listen((
  //       acceptedId,
  //     ) {
  //       emit(state.copyWith(driverId: acceptedId));
  //     });
  //   } catch (e) {
  //     emit(state.copyWith(errorMessage: e.toString()));
  //   }
  // }

  StreamSubscription? offerStream;
  void listenForMyOffer({required String orderId, required String offerId}) {
    try {
      offerStream?.cancel();
      offerStream = mainRepository.listenForMyOffer(orderId, offerId).listen((
        data,
      ) {
        if(data.status=='cancelled'||data.isAccepted==true) {
          offerStream?.cancel();
        }
        emit(state.copyWith(offer: data));
      });
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

  void reset() {
    cancelOrderStream();
    offerStream?.cancel();
    priceController.clear();
  }

  @override
  Future<void> close() {
   // driverIdStream?.cancel();
    priceController.dispose();
    cancelOrderStream();
    offerStream?.cancel();
    return super.close();
  }
}
