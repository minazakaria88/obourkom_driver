import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../orders/data/models/submit_order_model.dart';
import '../../../data/models/offer_model.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';
import 'order_details_item_widget.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({super.key, required this.model, this.offerModel});
  final SubmitOrderModel model;
  final OfferModel? offerModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
      buildWhen: (previous, current) =>
      previous.orderStatus != current.orderStatus ||
          previous.offer != current.offer,
      builder: (context, state) {
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
                  value: model.typeService ?? '',
                  title: S.of(context).serviceType,
                ),
                OrderDetailsItemWidget(
                  value: '${model.truckSizeId}',
                  title: S.of(context).carType,
                ),
                OrderDetailsItemWidget(
                  value: getStatusText(
                    context,
                    state.orderStatus ?? model.status ?? '',
                  ),
                  color: AppColors.greenColor,
                  title: S.of(context).orderStatus,
                ),
                OrderDetailsItemWidget(
                  value: model.paymentType ?? '',
                  title: S.of(context).paymentMethod,
                ),
                if (state.offer != null)
                  OrderDetailsItemWidget(
                    value: '${state.offer!.price ?? offerModel!.price ?? ''} ${S.of(context).sar} ',
                    title: S.of(context).orderValue,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
