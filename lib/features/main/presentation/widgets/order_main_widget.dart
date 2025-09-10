import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/app_colors.dart';

import '../../../../core/utils/app_styles.dart';

class OrderMainWidget extends StatelessWidget {
  const OrderMainWidget({
    super.key,
    required this.title,
    required this.value,
    required this.image,
  });
  final String title;
  final String value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          image,
          colorFilter: const ColorFilter.mode(
            AppColors.mainColor,
            BlendMode.srcIn,
          ),
        ),
        10.width,
        Text(title, style: AppTextStyles.regular12Grey.copyWith(fontSize: 14)),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bold14MainColor,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
