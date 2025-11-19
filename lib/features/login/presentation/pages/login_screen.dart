import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/helpers/validation_inputs_class.dart';
import 'package:obourkom_driver/core/utils/app_colors.dart';
import 'package:obourkom_driver/core/utils/app_styles.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/generated/assets.dart';
import 'package:obourkom_driver/generated/l10n.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helpers/show_snack_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_field.dart';
import '../cubit/login_cubit.dart';
import '../widgets/dont_have_an_account.dart';
import '../widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              showToastification(
                message: state.errorMessage ?? '',
                context: context,
                type: ToastificationType.error,
              );
            }
            if (state.isSuccess) {
              Navigator.pushNamed(
                context,
                Routes.otp,
                arguments: {
                  'phone': context.read<LoginCubit>().phoneController.text,
                  'otpType': OtpType.login,
                },
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            return Form(
              key: cubit.formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const LoginHeaderWidget(),
                        Row(
                          children: [
                            10.width,
                            Text(
                              S.of(context).phoneNumber,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        15.height,
                        MyTextFormField(
                          controller: cubit.phoneController,
                          validator: (String? value) {
                            return ValidationClass.validatePhone(
                              value,
                              context,
                            );
                          },
                          hint: '5xxxxxxxx',
                          textInputType: TextInputType.phone,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              '+966',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        25.height,
                        MyButton(
                          onTap: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                          title: S.of(context).enter,
                        ),
                        20.height,
                        const DontHaveAnAccount(),
                        60.height,
                        Text(
                          S.of(context).userApp,
                          style: AppTextStyles.regular12Grey.copyWith(
                            color: AppColors.mainColor,
                          ),
                        ),
                        10.height,
                        InkWell(
                          onTap: () {
                              launchUrl(Uri.parse('add user app link'));
                          },
                          child: SvgPicture.asset(Assets.imagesAppStore),
                        ),
                      ],
                    ),
                  ),
                  if (state.isLoading) const LoadingWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
