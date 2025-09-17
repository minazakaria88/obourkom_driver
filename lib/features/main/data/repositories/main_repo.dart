import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:obourkom_driver/core/api/api_helper.dart';
import 'package:obourkom_driver/core/functions/determine_position.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';

import '../../../../core/api/end_point.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';

class MainRepository {
  final ApiHelper apiHelper;
  MainRepository({required this.apiHelper});

  final firestore = FirebaseFirestore.instance.collection('orders');

  Stream<List<FirebaseOrderModel>> listenForOrders() async* {
    final position = await determinePosition();
    yield* firestore
        .orderBy('created_at', descending: true)
        .where('status', isEqualTo: 'available')
        .snapshots()
        .map(
          (e) => e.docs
              .map(
                (e) {
                  logger.d(e.data());
                  return  FirebaseOrderModel.fromJson(
                    e.data(),
                    position.latitude,
                    position.longitude,
                  );
                }
              )
              .toList(),
        );
  }

  Future<void> sendOffer({
    required String orderId,
    required String price,
  }) async {
    try {
      await apiHelper.postData(
        url: '${EndPoints.orders}/$orderId/offers',
        data: {'price': price},
      );
    } catch (e) {
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Stream<String> listenForDriverId(String orderId) {
    return firestore.doc(orderId).snapshots().map((e) => e['id_driver'].toString());
  }
}
