import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/widgets/loading_widget.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import '../../../../../core/helpers/validation_inputs_class.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../core/widgets/my_text_form_field.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listenWhen: (previous, current) => previous.sendOfferState!=current.sendOfferState,
      listener: (context, state) {
        if(state.sendOfferState==SendOfferState.success)
          {
            context.pop();
          }
      },
      buildWhen: (previous, current) => previous.sendOfferState!=current.sendOfferState,
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        return  Dialog(
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
                          S.of(context).confirmAddingOffer,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold18Black,
                        ),
                        20.height,
                        MyTextFormField(
                          textInputType: TextInputType.number,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 13.0),
                            child: Text('ر.س'),
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
                              cubit.sendOffer();
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
              if(state.isSendOfferLoading)
                const LoadingWidget(),
            ],
          ),
        );
      },
    );
  }
}
