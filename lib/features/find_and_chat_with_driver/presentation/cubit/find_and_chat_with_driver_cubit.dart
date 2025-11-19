import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obourkom_driver/core/network/failure.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/models/message_model.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/repositories/find_and_chat_repo.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/storage/cache_helper.dart';
import '../../../../core/utils/constant.dart';
import 'package:path/path.dart' as path;

import '../../../main/data/models/firebase_offer_model.dart';

part 'find_and_chat_with_driver_state.dart';

class FindAndChatWithDriverCubit extends Cubit<FindAndChatWithDriverState> {
  FindAndChatWithDriverCubit({required this.findAndChatWithDriverRepository})
    : super(const FindAndChatWithDriverState());

  final FindAndChatWithDriverRepository findAndChatWithDriverRepository;

 final TextEditingController messageController = TextEditingController();

   final TextEditingController priceController = TextEditingController();

   final formKey=GlobalKey<FormState>();

  StreamSubscription? messageStream;
  void listenForMessages({required String driverId, required String orderId}) {
    messageStream?.cancel();
    try {
      messageStream = findAndChatWithDriverRepository
          .getMessages(orderId: orderId, driverId: driverId)
          .listen(
            (messages) {
              emit(state.copyWith(messages: messages));
            },
            onError: (e) {
              emit(state.copyWith(errorMessage: e.toString()));
            },
          );
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
    try {
      await findAndChatWithDriverRepository.sendMessage(
        driverId: driverId,
        orderId: orderId,
        message: messageModel,
      );
      messageController.clear();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  StreamSubscription? orderStatusStream;
  void listenForOrderStatus({required String orderId}) {
    orderStatusStream?.cancel();
    try {
      orderStatusStream = findAndChatWithDriverRepository
          .getOrderStatus(orderId: orderId)
          .listen(
            (status) {
              logger.i(status);
              emit(state.copyWith(orderStatus: status));
            },
            onError: (e) {
              emit(state.copyWith(errorMessage: e.toString()));
            },
          );
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

  void pickImage1() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final tempDir = await getTemporaryDirectory();
      final savedImage = File(
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await File(photo.path).copy(savedImage.path);
      logger.f(savedImage.path);
      emit(state.copyWith(image: savedImage.path));
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (photo != null) {
      final ext = path.extension(photo.path);
      final tempDir = await getTemporaryDirectory();
      final savedImage = File(
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}$ext',
      );
      await File(photo.path).copy(savedImage.path);
      logger.f(savedImage.path);
      emit(state.copyWith(image: savedImage.path));
    }
  }

  void uploadPickImage({
    required String orderId,
    required String collection,
    required String status,
  }) async {
    try {
      emit(
        state.copyWith(uploadPickImageStatus: UploadPickImageStatus.loading),
      );
      final imageModel = await findAndChatWithDriverRepository.uploadImage(
        image: state.image ?? '',
        collection: collection,
      );
      logger.i('✅ Upload finished, got token: ${imageModel.token}');
      await changeOrderStatus(
        orderId: orderId,
        status: status,
        imageUrl: imageModel.token,
      );
      emit(
        state.copyWith(
          uploadPickImageStatus: UploadPickImageStatus.success,
          image: '',
        ),
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

  StreamSubscription? acceptOfferStream;
  void listenForMyOffer({required String orderId, required String offerId}) {
    try {
      logger.i('listenForMyOffer');
      acceptOfferStream?.cancel();
      acceptOfferStream = findAndChatWithDriverRepository
          .listenForMyOffer(orderId, offerId)
          .listen(
            (data) {
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

  void editOffer({
    required String orderId,
    required String offerId,
  }) async {
    try {
      emit(state.copyWith(editOfferStatus: EditOfferStatus.loading));
      await findAndChatWithDriverRepository.updateOffer(
        orderId: orderId,
        offerId: offerId,
        data: {
          'price': priceController.text
        },
      );
      emit(state.copyWith(editOfferStatus: EditOfferStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          editOfferStatus: EditOfferStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          editOfferStatus: EditOfferStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    messageStream?.cancel();
    orderStatusStream?.cancel();
    messageController.dispose();
    acceptOfferStream?.cancel();
    priceController.dispose();
    return super.close();
  }
}
