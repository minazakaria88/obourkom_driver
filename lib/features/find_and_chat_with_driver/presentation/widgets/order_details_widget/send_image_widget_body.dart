import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/generated/l10n.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../generated/assets.dart';

class SendImageWidgetBody extends StatelessWidget {
  const SendImageWidgetBody({
    super.key,
    required this.title1,
    required this.title2,
    required this.onSubmit,
    required this.uploadImage, required this.image,
  });
  final String title1;
  final String title2;
  final Function onSubmit;
  final Function uploadImage;
  final String image;

  @override
  Widget build(BuildContext context) {
    logger.i(image);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            blurRadius: 24,
            color: Colors.grey,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title1,
            style: AppTextStyles.regular16Black.copyWith(fontSize: 16),
          ),
          20.height,
          if(! image.isNullOrEmpty())
          Image.file(File(image),height: 100,fit: BoxFit.fill,width: double.infinity,),
          20.height,
          InkWell(
            onTap: () {
              uploadImage();
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
                    S.of(context).uploadPhotos,
                    style: AppTextStyles.bold14MainColor,
                  ),
                ],
              ),
            ),
          ),
          20.height,
          Builder(
            builder: (context) {
              return SlideAction(
                innerColor: AppColors.mainColor,
                outerColor: Colors.white,
                text: title2,
                sliderButtonIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                sliderButtonIconPadding: 12,
                key: key,
                sliderRotate: false,
                onSubmit: () async {
                  onSubmit();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
