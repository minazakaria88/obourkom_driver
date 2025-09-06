part of 'main_cubit.dart';

enum GetOrdersState { loading, success, failure }

enum SendOfferState {init, loading, success, failure }

extension MainStateX on MainState {
  bool get isSendOfferSuccess=> sendOfferState==SendOfferState.success;
  bool get isSendOfferLoading =>sendOfferState==SendOfferState.loading;
  bool get isSendOfferFail=>sendOfferState==SendOfferState.failure;

}

class MainState extends Equatable {
  String? errorMessage;
  bool? available;
  GetOrdersState? getOrdersState;
  SendOfferState? sendOfferState;
  List<String>? ordersIds;
  String ? order;
  String ? driverId;

  MainState({
    this.errorMessage,
    this.getOrdersState,
    this.available,
    this.ordersIds,
    this.sendOfferState,
    this.order,
    this.driverId,
  });

  MainState copyWith({
    GetOrdersState? getOrdersState,
    String? errorMessage,
    bool? available,
    List<String>? ordersIds,
    SendOfferState? sendOfferState,
    String ? order,
    String ?driverId
  }) {
    return MainState(
      available: available ?? this.available,
      errorMessage: errorMessage ?? this.errorMessage,
      getOrdersState: getOrdersState ?? this.getOrdersState,
      ordersIds: ordersIds ?? this.ordersIds,
      sendOfferState: sendOfferState ?? this.sendOfferState,
      order: order ?? this.order,
      driverId: driverId ?? this.driverId
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    available,
    getOrdersState,
    ordersIds,
    sendOfferState,
    order,
    driverId
  ];
}
