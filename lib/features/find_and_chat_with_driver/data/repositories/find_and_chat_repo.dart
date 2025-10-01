import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:obourkom_driver/core/api/end_point.dart';
import 'package:obourkom_driver/core/api/failure.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/models/message_model.dart';
import '../../../../core/api/api_helper.dart';
import '../../../main/data/models/firebase_offer_model.dart';
import '../models/image_model.dart';

class FindAndChatWithDriverRepository {
  final ApiHelper apiHelper;

  FindAndChatWithDriverRepository({required this.apiHelper});

  final firestore = FirebaseFirestore.instance.collection('orders');

  Stream<List<MessageModel>> getMessages({
    required String orderId,
    required String driverId,
  }) {
    logger.d('${EndPoints.orders}/$orderId/offers/$driverId/chat');
    return firestore
        .doc(orderId)
        .collection('chat')
        .doc(driverId)
        .collection('messages')
        .orderBy('created_at')
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => MessageModel.fromJson(e.data())).toList(),
        );
  }

  Future<void> sendMessage({
    required String orderId,
    required String driverId,
    required MessageModel message,
  }) async {
    // await apiHelper.postData(
    //   url: '${EndPoints.orders}/$orderId/offers/$driverId/chat',
    //   data: message.toJson(),
    // );
    await firestore
        .doc(orderId)
        .collection('chat')
        .doc(driverId)
        .collection('messages')
        .add(message.toJson());
  }

  Future<void> sendMessageToDriver({
    required String orderId,
    required String offerId,
    required MessageModel message,
  }) async {
    await apiHelper.postData(
      url: '${EndPoints.orders}/$orderId/offers/$offerId/chat',
      data: message.toJson(),
    );
  }

  Stream<String> getOrderStatus({required String orderId}) {
    return firestore.doc(orderId).snapshots().map((event) => event['status']);
  }

  Future<void> changeOrderStatus({
    required String orderId,
    required String status,
    String? imageUrl,
  }) async {
    try {
      final data = {'status': status, if (imageUrl != null) 'image': imageUrl};
      final response = await apiHelper.postData(
        url: '${EndPoints.orders}/change-status/$orderId',
        data: data,
      );
      logger.d(response);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<ImageModel> uploadImage({
    required String image,
    required String collection,
  }) async {
    try {
      final data = FormData.fromMap({
        'file': await MultipartFile.fromFile(image),
        'collection': collection,
      });
      final response = await apiHelper.postData(
        url: EndPoints.uploadImage,
        data: data,
      );
      logger.i(response);
      return ImageModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Stream<FirebaseOfferModel> listenForMyOffer(String orderId, String offerId) {
    return firestore
        .doc(orderId)
        .collection('offers')
        .doc(offerId)
        .snapshots()
        .map((e) => FirebaseOfferModel.fromJson(e.data()!));
  }

  Future<void> updateOffer({
    required String orderId,
    required String offerId,
    required dynamic data,
  }) async {
    try {
      await apiHelper.putData(
        url: '${EndPoints.orders}/$orderId/offers/$offerId',
        data: data,
      );
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }
}
