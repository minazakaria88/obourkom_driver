part of 'find_and_chat_with_driver_cubit.dart';


enum UploadPickImageStatus { initial, loading, success, failure }

enum EditOfferStatus { initial, loading, success, failure }

class FindAndChatWithDriverState extends Equatable {
  final List<MessageModel>? messages;
  final String? errorMessage;
  final String? orderStatus;
  final String? image;
  final UploadPickImageStatus? uploadPickImageStatus;
  final  FirebaseOfferModel? offer;
  final EditOfferStatus? editOfferStatus;


  const FindAndChatWithDriverState({
    this.messages,
    this.errorMessage,
    this.orderStatus,
    this.uploadPickImageStatus = UploadPickImageStatus.initial,
    this.image,
    this.offer,
    this.editOfferStatus=EditOfferStatus.initial
  });

  FindAndChatWithDriverState copyWith({

    List<MessageModel>? messages,
    String? errorMessage,
    String? orderStatus,
    String? image,
    UploadPickImageStatus? uploadPickImageStatus,
    FirebaseOfferModel? offer,
    EditOfferStatus? editOfferStatus

  }) {
    return FindAndChatWithDriverState(
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      orderStatus: orderStatus ?? this.orderStatus,
      uploadPickImageStatus:
      uploadPickImageStatus ?? this.uploadPickImageStatus,
      image: image ?? this.image,
      offer: offer ?? this.offer,
      editOfferStatus: editOfferStatus ?? this.editOfferStatus

    );
  }

  @override
  List<Object?> get props => [
    messages,
    errorMessage,
    orderStatus,
    uploadPickImageStatus,
    image,
    offer,
    editOfferStatus
  ];
}

