import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/firebase_order_model.dart';
import '../order_location_details.dart';
import '../order_main_widget.dart';

class SelectedOrderDetails extends StatelessWidget {
  const SelectedOrderDetails({super.key, required this.model});
  final FirebaseOrderModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          initiallyExpanded: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(
            S.of(context).details,
            style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
          ),
          backgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.all(10),
          children: [
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            OrderMainWidget(
              image: Assets.imagesDocuments,
              title: S.of(context).orderNumber,
              value: '#${model.id}',
            ),
            20.height,
            OrderMainWidget(
              image: Assets.imagesServicesType,
              title: S.of(context).serviceType,
              value: model.typeService ??'',
            ),
            20.height,
            OrderMainWidget(
              title: S.of(context).tripDistance,
              value: '${model.tripDistance} كم',
              image: Assets.imagesTripDistance,
            ),
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    S.of(context).expectedTransportationCost,
                    style: AppTextStyles.bold14Grey.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  child: Text(
                    '${S.of(context).from} ${model.priceFrom}  ${S.of(context).to} ${model.priceTo} ${S.of(context).sar}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold14MainColor.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            OrderLocationDetails(model: model,),
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            Text(S.of(context).notes, style: AppTextStyles.bold14Grey),
            10.height,
            Text(
              model.notes ??'',
            ),
          ],
        ),
      ),
    );
  }
}
