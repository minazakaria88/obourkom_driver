import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: AppTextStyles.bold18Black),
        const Spacer(),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xff065C73).withAlpha(40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.imagesUploadImage),
                10.width,
                Text(
                  S.of(context).uploadPhoto,
                  style: AppTextStyles.bold14MainColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
