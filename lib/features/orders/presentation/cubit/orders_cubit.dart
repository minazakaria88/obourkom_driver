import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:obourkom_driver/features/orders/data/models/order_model.dart';
import 'package:obourkom_driver/features/orders/data/models/submit_order_model.dart';
import '../../../../core/api/failure.dart';
import '../../data/repositories/order_repo.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({required this.orderRepository}) : super(OrdersState());
  final OrderRepository orderRepository;



  void getOrders(int page) async {
    emit(state.copyWith(getOrdersStatus: GetOrdersStatus.loading));
    try {
      final result = await orderRepository.getOrders(page);
      final recentOrder = List<OrderDataModel>.from([]);
      final completedOrder = List<OrderDataModel>.from([]);
      final orders = result.data ?? [];
      for (var element in orders) {
        if (element.status == 'delivered') {
          completedOrder.add(element);
        }
        else {
          recentOrder.add(element);
        }
      }
      emit(
        state.copyWith(
          getOrdersStatus: GetOrdersStatus.success,
          recentOrdersList: state.recentOrdersList == null
              ? recentOrder
              : [...state.recentOrdersList!, ...recentOrder],
          completedOrdersList: state.completedOrdersList == null
              ? completedOrder
              : [...state.completedOrdersList!, ...completedOrder],
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          getOrdersStatus: GetOrdersStatus.failure,
          errorMessage: e.failure.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getOrdersStatus: GetOrdersStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getMoreOrders(ScrollController scrollController) async {
    int page = 2;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (state.getOrdersStatus != GetOrdersStatus.loading) {
          getOrders(page++);
        }
      }
    });
  }



}
