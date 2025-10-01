import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/functions/show_snack_bar.dart';
import '../../../../../core/helpers/validation_inputs_class.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../core/widgets/my_text_form_field.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class EditOfferDialogWidget extends StatelessWidget {
  const EditOfferDialogWidget({
    super.key,
    required this.offerId,
    required this.orderId,
  });
  final String offerId;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
      listenWhen: (previous, current) =>
          previous.editOfferStatus != current.editOfferStatus,
      listener: (context, state) {
        if (state.editOfferStatus == EditOfferStatus.success) {
          showToastification(
            message: S.of(context).editOfferSuccessfully,
            context: context,
            type: ToastificationType.success,
          );
          context.pop();
        }
      },
      buildWhen: (previous, current) =>
          previous.editOfferStatus != current.editOfferStatus,
      builder: (context, state) {
        final cubit = context.read<FindAndChatWithDriverCubit>();
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.height,
                        SvgPicture.asset(Assets.imagesPrice),
                        20.height,
                        Text(
                          S.of(context).EnterNewPrice,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold18Black,
                        ),
                        20.height,
                        MyTextFormField(
                          textInputType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: Text(S.of(context).sar),
                          ),
                          controller: cubit.priceController,
                          hint: '0.00',
                          validator: (value) {
                            return ValidationClass.validateText(
                              value,
                              S.of(context).pleaseEnterThePrice,
                            );
                          },
                        ),
                        10.height,
                        MyButton(
                          title: S.of(context).confirm,
                          onTap: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.editOffer(
                                orderId: orderId,
                                offerId: offerId,
                              );
                            }
                          },
                        ),
                        MyButton(
                          title: S.of(context).close,
                          onTap: () {
                            context.pop();
                          },
                          color: const Color(0xffF5FAFA),
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.editOfferStatus == EditOfferStatus.loading)
                const LoadingWidget(),
            ],
          ),
        );
      },
    );
  }
}
