
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/app_styles.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(Assets.imagesDriver),
        15.height,
        Text(
          S.of(context).createAccount,
          style: AppTextStyles.bold24Black,
        ),
        10.height,
      ],
    );
  }
}
