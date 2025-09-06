import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/app_styles.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import 'choose_language_widget.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        50.height,
        const ChooseLanguageWidget(),
        20.height,
        SvgPicture.asset(Assets.imagesDriver),
        30.height,
        Text(
          S.of(context).welcomeBack,
          style: AppTextStyles.bold24Black,
        ),
        20.height,
        Text(
          S.of(context).haveFun,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular16Black,
        ),
        20.height,
      ],
    );
  }
}
