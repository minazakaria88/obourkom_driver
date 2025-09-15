import 'package:flutter/material.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../orders/data/models/submit_order_model.dart';
import 'order_details_item_widget.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key, required this.model,
  });
  final SubmitOrderModel model;

  @override
  Widget build(BuildContext context) {
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: ExpansionTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              title: Text(
                S.of(context).orderDetails,
                style: AppTextStyles.bold18Black,
              ),
              children: [
                OrderDetailsItemWidget(
                  value: '#${model.id}',
                  title: S.of(context).orderNumber,
                ),
                OrderDetailsItemWidget(
                  value: '${model.typeService}',
                  title: S.of(context).serviceType,
                ),
                OrderDetailsItemWidget(
                  value: '${model.truckTypeId}',
                  title: S.of(context).carType,
                ),
                OrderDetailsItemWidget(
                  value: getStatusText(context,model.status ??''),
                  title: S.of(context).orderStatus,
                ),
                OrderDetailsItemWidget(
                  value: model.paymentType ??'',
                  title: S.of(context).paymentMethod,
                ),
              ],
            ),
          ),
        );
  }
}
