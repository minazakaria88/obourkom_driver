import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../orders/data/models/submit_order_model.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class OrderTimerWidget extends StatelessWidget {
  const OrderTimerWidget({
    super.key, required this.model,
  });
  final SubmitOrderModel model;

  @override
  Widget build(BuildContext context) {
    return BackgroundProfileWidget(
      child: BlocBuilder<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
        buildWhen: (previous, current) =>
        previous.orderTimerDuration != current.orderTimerDuration,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(width: double.infinity),
                Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withAlpha(10),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(Assets.imagesClock),
                      20.height,
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          '${state.orderTimerDuration!.inMinutes.toString().padLeft(2, '0')} : ${state.orderTimerDuration!.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                          style: AppTextStyles.bold14MainColor,
                        ),
                      ),
                    ],
                  ),
                ),

                10.height,
                Text(
                  S.of(context).lookingForOffers,
                  style: AppTextStyles.bold14Grey.copyWith(
                    color: Colors.black,
                  ),
                ),
                10.height,
                Text(
                  S.of(context).itWillTakeSomeTime,
                  style: AppTextStyles.bold14Grey.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
                15.height,
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.shadowColor.withAlpha(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).expectedTransportationCost,
                        style: AppTextStyles.bold14Grey.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      10.width,
                      Flexible(
                        child: Text(
                          'من ${model.priceFrom} الي ${model.priceTo} ريال',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold14MainColor.copyWith(
                            fontSize: 16,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
