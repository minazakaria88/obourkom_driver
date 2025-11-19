import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/helpers/make_phone_call.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/profile_image.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class CallAndChatWithUser extends StatelessWidget {
  const CallAndChatWithUser({
    super.key,
    required this.cubit, required this.orderId, required this.userName, required this.userPhone,
  });

  final FindAndChatWithDriverCubit cubit;
  final String orderId;
  final String userName;
  final String userPhone;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BackgroundProfileWidget(
        child: Row(
          children: [
            const ProfileImage(width: 60, height: 60),
            20.width,
            Text(
              userName,
              style: AppTextStyles.bold18Black,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                makePhoneCall(phoneNumber: userPhone);
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.greenColor,
                ),
                child: SvgPicture.asset(
                  Assets.imagesPhoneCalling,
                ),
              ),
            ),
            10.width,
            InkWell(
              onTap: () {
                context.pushNamed(
                  Routes.chatScreen,
                  arguments: {
                    'orderId': orderId,
                    'cubit': cubit,
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.darkMainColor,
                ),
                child: const Icon(
                  Icons.message_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
