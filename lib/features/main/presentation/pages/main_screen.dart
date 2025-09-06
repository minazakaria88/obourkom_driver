import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import 'package:obourkom_driver/features/main/presentation/widgets/order_item_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../widgets/main_widget.dart';
import '../widgets/switch_status_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          50.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<MainCubit, MainState>(
                buildWhen: (previous, current) =>
                    previous.available != current.available,
                builder: (context, state) {
                  final cubit = context.read<MainCubit>();
                  return Row(
                    children: [
                      Text(
                        state.available!
                            ? S.of(context).ready
                            : S.of(context).stoppable,
                      ),
                      10.width,
                      SwitchStatusWidget(
                        onTap: (value) {
                          cubit.toggleSwitch(value);
                        },
                        flag: state.available!,
                      ),
                    ],
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<HomeCubit>().changeIndex(2);
                },
                icon: SvgPicture.asset(Assets.imagesNotification),
              ),
            ],
          ),
          25.height,
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) => !state.available!
                ? const Expanded(
                    child: MainWidget(
                      text1: 'انت الان غير متصل',
                      text2: 'لن يمكنك تلقي اي طلبات',
                      image: Assets.imagesStop,
                    ),
                  )
                : state.ordersIds == null || state.ordersIds!.isEmpty
                ? const Expanded(
                    child: MainWidget(
                      image: Assets.imagesOfflineBolt,
                      text1: 'جاري البحث...',
                      text2: 'يتم الان البحث عن طلبات بالقرب من موقعك',
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.ordersIds!.length,
                      itemBuilder: (context, index) =>
                          OrderItemWidget(order: state.ordersIds![index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
