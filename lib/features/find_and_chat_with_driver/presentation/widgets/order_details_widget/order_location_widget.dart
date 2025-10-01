import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/presentation/widgets/add_offers_widgets/got_to_map_widget.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';

class OrderLocationWidget extends StatelessWidget {
  const OrderLocationWidget({
    super.key,
     required this.title, required this.location, required this.latitude, required this.longitude,
  });

  final String title;
  final String location;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BackgroundProfileWidget(
        child: Row(

          children: [
            SvgPicture.asset(Assets.imagesLocation),
            10.width,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.regular16Black,
                      ),
                      const Spacer(),
                      GoToMapWidget(lat: latitude, lng: longitude),
                    ],
                  ),
                  5.height,
                  Text(
                    location,
                    style: AppTextStyles.regular12Grey.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
