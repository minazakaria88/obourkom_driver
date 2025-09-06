import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obourkom_driver/core/api/failure.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/models/message_model.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/models/offer_model.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/repositories/find_and_chat_repo.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/utils/constant.dart';
part 'find_and_chat_with_driver_state.dart';

class FindAndChatWithDriverCubit extends Cubit<FindAndChatWithDriverState> {
  FindAndChatWithDriverCubit({required this.findAndChatWithDriverRepository})
    : super(
        FindAndChatWithDriverState(
          orderTimerDuration: const Duration(minutes: 5),
        ),
      );

  final FindAndChatWithDriverRepository findAndChatWithDriverRepository;


  TextEditingController messageController = TextEditingController();

  StreamSubscription? messageStream;
  void listenForMessages({required String driverId, required String orderId}) {
    try {
      messageStream?.cancel();
      messageStream = findAndChatWithDriverRepository
          .getMessages(orderId: orderId, driverId: driverId)
          .listen((messages) {
            emit(state.copyWith(messages: messages));
          });
      logger.d(state.messages);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void sendMessage({
    required String driverId,
    required String orderId,
    required String message,
  }) async {
    final String customerId = CacheHelper.getData(
      key: CacheHelperKeys.customerId,
    ).toString();
    MessageModel messageModel = MessageModel(
      message: message,
      dateTime: DateTime.now(),
      senderId: customerId,
      receiverId: driverId,
    );
    logger.d(messageModel);
    await findAndChatWithDriverRepository.sendMessage(
      driverId: driverId,
      orderId: orderId,
      message: messageModel,
    );
    messageController.clear();
  }

  StreamSubscription? orderStatusStream;
  void listenForOrderStatus({required String orderId}) {
    try {
      orderStatusStream?.cancel();
      orderStatusStream = findAndChatWithDriverRepository
          .getOrderStatus(orderId: orderId)
          .listen((status) {
            emit(state.copyWith(orderStatus: status));
          });
      logger.d(state.orderStatus);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> changeOrderStatus({
    required String orderId,
    required String status,
    String? imageUrl,
  }) async {
    await findAndChatWithDriverRepository.changeOrderStatus(
      orderId: orderId,
      status: status,
      imageUrl: imageUrl,
    );
  }

  void pickImage({
    required String orderId,
    required String collection,
    required String status,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      uploadPickImage(
        image: photo.path,
        orderId: orderId,
        collection: collection,
        status: status,
      );
    }
  }

  void uploadPickImage({
    required String image,
    required String orderId,
    required String collection,
    required String status,
  }) async {
    try {
      emit(
        state.copyWith(uploadPickImageStatus: UploadPickImageStatus.loading),
      );
      final imageModel = await findAndChatWithDriverRepository.uploadImage(
        image: image,
        collection: collection,
      );
      await changeOrderStatus(
        orderId: orderId,
        status: status,
        imageUrl: imageModel.token,
      );
      emit(
        state.copyWith(uploadPickImageStatus: UploadPickImageStatus.success),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          uploadPickImageStatus: UploadPickImageStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          uploadPickImageStatus: UploadPickImageStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    messageStream?.cancel();
    orderStatusStream?.cancel();
    messageController.dispose();
    return super.close();
  }
}
