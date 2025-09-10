import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../generated/assets.dart';
import 'from_to_location_widget.dart';

class OrderLocationDetails extends StatelessWidget {
  const OrderLocationDetails({
    super.key, required this.model,
  });
  final FirebaseOrderModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              Assets.imagesLocation,
              colorFilter: const ColorFilter.mode(
                AppColors.mainColor,
                BlendMode.srcIn,
              ),
            ),
            const DottedLine(
              lineLength: 80,
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
            ),
            SvgPicture.asset(Assets.imagesLocation),
          ],
        ),
        10.width,
         FromToLocationWidget(model: model,),
      ],
    );
  }
}
