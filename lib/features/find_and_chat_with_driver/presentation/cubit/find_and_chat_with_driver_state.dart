part of 'find_and_chat_with_driver_cubit.dart';


enum UploadPickImageStatus { initial, loading, success, failure }

class FindAndChatWithDriverState extends Equatable {
  Duration? orderTimerDuration;
  List<OfferModel>? offers;
  List<MessageModel>? messages;
  String? errorMessage;
  String ? orderStatus;
  String ? image;

  UploadPickImageStatus ?uploadPickImageStatus = UploadPickImageStatus.initial;

  FindAndChatWithDriverState({
    this.orderTimerDuration,
    this.offers,
    this.messages,
    this.errorMessage,
    this.orderStatus,
    this.uploadPickImageStatus,
    this.image
  });

  FindAndChatWithDriverState copyWith({
    Duration? orderTimerDuration,
    List<OfferModel>? offers,
    List<MessageModel>? messages,
    String? errorMessage,
    String? orderStatus,
    String ?image,
    UploadPickImageStatus? uploadPickImageStatus
  }) {
    return FindAndChatWithDriverState(
      orderTimerDuration: orderTimerDuration ?? this.orderTimerDuration,
      offers: offers ?? this.offers,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      orderStatus: orderStatus ?? this.orderStatus,
      uploadPickImageStatus: uploadPickImageStatus ?? this.uploadPickImageStatus,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    orderTimerDuration,
    offers,
    messages,
    errorMessage,
    orderStatus,
    uploadPickImageStatus,
    image
  ];
}
