import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';

class FromToLocationWidget extends StatelessWidget {
  const FromToLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                S.of(context).from,
                style: AppTextStyles.regular16Black
                    .copyWith(fontSize: 14),
              ),
              const Spacer(),
              const Text(
                'علي بعد 1.0 كم',
                style: TextStyle(
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
          10.height,
          const Text(
            '6660 رباح مولي ابن حججي، BCAB3985، 3985، العقيق 65915، المملكة العربية السعودية',
            maxLines: 1,
            style: TextStyle(color: Color(0xff616A6B)),
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
              const Text(
                'علي بعد 1.0 كم',
                style: TextStyle(
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
          10.height,
          const Text(
            '6660 رباح مولي ابن حججي، BCAB3985، 3985، العقيق 65915، المملكة العربية السعودية',
            maxLines: 1,
            style: TextStyle(color: Color(0xff616A6B)),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
