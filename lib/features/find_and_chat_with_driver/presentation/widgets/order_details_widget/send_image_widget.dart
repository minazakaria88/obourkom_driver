import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/core/widgets/loading_widget.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/send_image_widget_body.dart';
import 'package:obourkom_driver/generated/l10n.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/functions/show_snack_bar.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class SendImageWidget extends StatelessWidget {
  const SendImageWidget({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
      listenWhen: (previous, current) =>
          previous.uploadPickImageStatus != current.uploadPickImageStatus,
      listener: (context, state) {
        if (state.uploadPickImageStatus == UploadPickImageStatus.failure) {
          showToastification(
            message: state.errorMessage ?? '',
            context: context,
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<FindAndChatWithDriverCubit>();
        if (state.orderStatus == onTheWayToDelivery) {
          return Stack(
            children: [
              SendImageWidgetBody(
                uploadImage: () {
                  cubit.pickImage();
                },
                image: state.image ?? '',
                onSubmit: () {
                  if(!state.image.isNullOrEmpty()){
                  cubit.uploadPickImage(
                    orderId: orderId,
                    collection: 'finished_images',
                    status: delivered,
                  );}
                },
                title1: S.of(context).pleaseSubmitTheOrderAndPressTheButton,
                title2: S.of(context).delivered,
              ),
              if (state.uploadPickImageStatus == UploadPickImageStatus.loading)
                const LoadingWidget(),
            ],
          );
        } else if (state.orderStatus == onTheWayToPickup) {
          return Stack(
            children: [
              SendImageWidgetBody(
                onSubmit: () {
                  if(!state.image.isNullOrEmpty()){
                    cubit.uploadPickImage(
                      orderId: orderId,
                      collection: 'processed_images',
                      status: onTheWayToDelivery,
                    );
                  }

                },
                image: state.image,
                uploadImage: () {
                  cubit.pickImage();
                },
                title1: S.of(context).pleaseReceiveTheOrderAndPressTheButton,
                title2: S.of(context).received,
              ),
              if (state.uploadPickImageStatus == UploadPickImageStatus.loading)
                const LoadingWidget(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
