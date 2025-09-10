import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';

class FromToLocationWidget extends StatelessWidget {
  const FromToLocationWidget({
    super.key, required this.model,
  });
  final FirebaseOrderModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).from,
                style: AppTextStyles.regular16Black
                    .copyWith(fontSize: 14),
              ),
              const Spacer(),
               Text(
                'علي بعد ${model.distanceBetweenDriverAndPickup} كم',
                style: const TextStyle(
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
          10.height,
           Text(
            model.fromAddress,
            maxLines: 1,
            style: const TextStyle(color: Color(0xff616A6B)),
            overflow: TextOverflow.ellipsis,
          ),
          30.height,

          Row(
            children: [
              Text(
                S.of(context).to,
                style: AppTextStyles.regular16Black
                    .copyWith(fontSize: 14),
              ),
              const Spacer(),
               Text(
                'علي بعد ${model.distanceBetweenDriverAndDropOff} كم',
                style: const TextStyle(
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
          10.height,
           Text(
            model.toAddress,
            maxLines: 1,
            style: const TextStyle(color: Color(0xff616A6B)),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
