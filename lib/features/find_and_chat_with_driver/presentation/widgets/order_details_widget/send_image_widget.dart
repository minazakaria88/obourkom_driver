import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/send_image_widget_body.dart';
import 'package:obourkom_driver/generated/l10n.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class SendImageWidget extends StatelessWidget {
  const SendImageWidget({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final cubit = context.read<FindAndChatWithDriverCubit>();
        return SendImageWidgetBody(
          onSubmit: () {

          },
          title1: S.of(context).pleaseSubmitTheOrderAndPressTheButton,
          title2: S.of(context).delivered,
        );
      },
    );
  }
}
