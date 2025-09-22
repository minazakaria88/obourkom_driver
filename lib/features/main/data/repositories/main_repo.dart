import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:obourkom_driver/core/api/api_helper.dart';
import 'package:obourkom_driver/core/functions/determine_position.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_offer_model.dart';
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
          (e) => e.docs.map((e) {
            logger.d(e.data());
            return FirebaseOrderModel.fromJson(
              e.data(),
              position.latitude,
              position.longitude,
            );
          }).toList(),
        );
  }

  Future<int> sendOffer({
    required String orderId,
    required String price,
  }) async {
    try {
      final response = await apiHelper.postData(
        url: '${EndPoints.orders}/$orderId/offers',
        data: {'price': price},
      );
      logger.i(response);
      return response.data['offer']['id'];
    } catch (e) {
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Stream<String> listenForDriverId(String orderId) {
    return firestore
        .doc(orderId)
        .snapshots()
        .map((e) => e['id_driver'].toString());
  }

  Stream<FirebaseOfferModel> listenForMyOffer(String orderId, String offerId) {
    return firestore
        .doc(orderId)
        .collection('offers')
        .doc(offerId)
        .snapshots()
        .map((e) => FirebaseOfferModel.fromJson(e.data()!));
  }
}
