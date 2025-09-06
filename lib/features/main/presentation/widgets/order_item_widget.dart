import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import 'order_location_details.dart';
import 'order_main_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.order});
  final String order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 0),
            color: Colors.grey.withAlpha((0.2 * 255).toInt()),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          OrderMainWidget(
            image: Assets.imagesServicesType,
            title: S.of(context).serviceType,
            value: 'نقل أثاث',
          ),
          20.height,
          OrderMainWidget(
            title: S.of(context).tripDistance,
            value: '$order  كم ',
            image: Assets.imagesTripDistance,
          ),
          20.height,
          const OrderLocationDetails(),
          20.height,
          MyButton(
            title: S.of(context).showDetails,
            onTap: () {
              context.read<MainCubit>().assignOrder(order);
              context.pushNamed(
                Routes.addOfferScreen,
                arguments: context.read<MainCubit>(),
              );
            },
          ),
        ],
      ),
    );
  }
}
