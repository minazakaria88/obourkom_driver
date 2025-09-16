import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../orders/data/models/submit_order_model.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class OrderLocationWidget extends StatelessWidget {
  const OrderLocationWidget({
    super.key,
    required this.orderModel,
  });

  final SubmitOrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BackgroundProfileWidget(
        child: Row(
          children: [
            SvgPicture.asset(Assets.imagesLocation),
            10.width,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).location,
                    style: AppTextStyles.regular16Black,
                  ),
                  5.height,
                  BlocBuilder<
                      FindAndChatWithDriverCubit,
                      FindAndChatWithDriverState
                  >(
                    buildWhen: (previous, current) =>
                    previous.orderStatus != current.orderStatus,
                    builder: (context, state) {
                      return Text(
                        state.orderStatus == null ||
                            statusToNumber[state
                                .orderStatus]! <=
                                1
                            ? orderModel.addressFrom ?? ''
                            : orderModel.addressTo ?? '',
                        style: AppTextStyles.regular12Grey.copyWith(
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
