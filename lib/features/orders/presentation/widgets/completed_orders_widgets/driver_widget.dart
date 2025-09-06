import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/profile_image.dart';
import '../../../data/models/order_model.dart';

class CompleteOrderDriverWidget extends StatelessWidget {
  const CompleteOrderDriverWidget({
    super.key, required this.driver,
  });
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return BackgroundProfileWidget(
      child: Row(
        children: [
          const ProfileImage(),
          20.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driver.name?? '', style: AppTextStyles.bold18Black),
              Row(
                children: [
                  SvgPicture.asset(Assets.imagesStars),
                  5.width,
                  Text('4.5', style: AppTextStyles.bold18Black),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
