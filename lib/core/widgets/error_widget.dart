import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/app_styles.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import 'my_button.dart';

class ErrorAppWidget extends StatelessWidget {
  const ErrorAppWidget({super.key, this.onRetry});
final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50, width: double.infinity),
        Image.asset(
          Assets.imagesError,
          fit: BoxFit.fill,
          height: 200,
          width: 200,
        ),
        20.height,
        Text(
          S.of(context).somethingWentWrong,
          style: AppTextStyles.bold18Black,
        ),
        20.height,
        MyButton(
          title: S.of(context).retry,
          onTap: () {
            onRetry?.call();
          },
        ),
      ],
    );
  }
}
