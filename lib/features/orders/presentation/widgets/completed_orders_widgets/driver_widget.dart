import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/profile_image.dart';

class CompleteOrderDriverWidget extends StatelessWidget {
  const CompleteOrderDriverWidget({
    super.key, required this.userName,
  });
  final String userName;

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
              Text(userName, style: AppTextStyles.bold18Black),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
