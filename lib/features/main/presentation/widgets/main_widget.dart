import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../core/utils/app_styles.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key, required this.text1, required this.text2, required this.image,
  });
  final String text1;
  final String text2;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        10.height,
        Text(
          text1,
          style: AppTextStyles.bold24Black.copyWith(fontSize: 20),
        ),
        10.height,
        Text(
          text2,
          style: AppTextStyles.bold14MainColor.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
