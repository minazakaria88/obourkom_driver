import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';

class SwitchStatusWidget extends StatelessWidget {
  const SwitchStatusWidget({
    super.key,
    required this.flag,
    required this.onTap,
  });

  final bool flag;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: AppColors.mainColor,
      value: flag,
      onChanged: (value) {
        showBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).changeStatus,
                  style: AppTextStyles.bold24Black.copyWith(fontSize: 20),
                ),
                10.height,
                MyButton(
                  title: S.of(context).ready,
                  onTap: () {
                    onTap(true);
                    context.pop();
                  },
                ),
                10.height,
                MyButton(
                  title: S.of(context).stayNotConnected,
                  onTap: () {
                    onTap(false);
                    context.pop();
                  },
                  color: const Color(0xffF5FAFA),
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        );

        //cubit.toggleSwitch(value);
      },
    );
  }
}
