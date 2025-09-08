import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/cubit/find_and_chat_with_driver_cubit.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/dotted_widget.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import 'order_stepper_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
      listenWhen: (previous, current) => previous.orderStatus!=current.orderStatus,
      listener: (context, state) {
        if (state.orderStatus == delivered) {
          context.pushNamedAndRemoveUntil(Routes.home, (r) => false);
        }
      },
      buildWhen: (previous, current) =>
          previous.orderStatus != current.orderStatus,
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStepperWidget(
                  isActive: state.orderStatus == null
                      ? false
                      : statusToNumber[state.orderStatus]! >= 0,
                  title: S.of(context).negotiation,
                  image: Assets.imagesNegoti,
                ),
                const DottedWidget(),
                OrderStepperWidget(
                  isActive: state.orderStatus == null
                      ? false
                      : statusToNumber[state.orderStatus]! >= 1,
                  title: S.of(context).onYourWay,
                  image: Assets.imagesDriverOnWay,
                ),
                const DottedWidget(),
                OrderStepperWidget(
                  isActive: state.orderStatus == null
                      ? false
                      : statusToNumber[state.orderStatus]! >= 2,
                  title: S.of(context).theDriverHasArrived,
                  image: Assets.imagesDriverArrive,
                ),
                const DottedWidget(),
                OrderStepperWidget(
                  isActive: state.orderStatus == null
                      ? false
                      : statusToNumber[state.orderStatus]! >= 3,
                  title: S.of(context).theShipmentHasArrived,
                  image: Assets.imagesShipmentArrive,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
