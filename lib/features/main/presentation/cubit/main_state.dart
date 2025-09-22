part of 'main_cubit.dart';

enum GetOrdersState { loading, success, failure }

enum SendOfferState { init, loading, success, failure }

extension MainStateX on MainState {
  bool get isSendOfferSuccess => sendOfferState == SendOfferState.success;
  bool get isSendOfferLoading => sendOfferState == SendOfferState.loading;
  bool get isSendOfferFail => sendOfferState == SendOfferState.failure;
}

@immutable
class MainState extends Equatable {
  final String? errorMessage;
  final bool? available;
  final GetOrdersState? getOrdersState;
  final SendOfferState? sendOfferState;
  final List<FirebaseOrderModel>? ordersIds;
  final FirebaseOfferModel? offer;

  const MainState({
    this.errorMessage,
    this.getOrdersState,
    this.available,
    this.ordersIds,
    this.sendOfferState,
    this.offer,
  });

  MainState copyWith({
    GetOrdersState? getOrdersState,
    String? errorMessage,
    bool? available,
    List<FirebaseOrderModel>? ordersIds,
    SendOfferState? sendOfferState,
    String? driverId,
    FirebaseOfferModel? offer,
  }) {
    return MainState(
      available: available ?? this.available,
      errorMessage: errorMessage ?? this.errorMessage,
      getOrdersState: getOrdersState ?? this.getOrdersState,
      ordersIds: ordersIds ?? this.ordersIds,
      sendOfferState: sendOfferState ?? this.sendOfferState,
      offer: offer ?? this.offer,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    available,
    getOrdersState,
    ordersIds,
    sendOfferState,
    offer,
  ];
}
