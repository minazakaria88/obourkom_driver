import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/l10n.dart';

class CompleteOrderInvoiceAndEvaluationWidget extends StatelessWidget {
  const CompleteOrderInvoiceAndEvaluationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MyButton(
          title: S.of(context).Invoice,
          color: AppColors.mainColor,
          onTap: () {},
        ),
      ),
    );
  }
}
