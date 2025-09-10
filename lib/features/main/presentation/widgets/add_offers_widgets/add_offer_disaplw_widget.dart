import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/l10n.dart';

class AddOfferDisableWidget extends StatelessWidget {
  const AddOfferDisableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color:  AppColors.greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          S.of(context).addOffer,
          style: const TextStyle(
            color:  Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
