import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/edit_offer_dialog_widget.dart';
import 'package:obourkom_driver/features/profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

class EditOfferWidget extends StatelessWidget {
  const EditOfferWidget({
    super.key,
    required this.orderId,
    required this.offerId,
  });
  final String orderId;
  final String offerId;
  @override
  Widget build(BuildContext context) {
    logger.i(offerId);
    logger.i(orderId);
    return SliverToBoxAdapter(
      child:
          BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
            listener: (context, state) {},
            builder: (context, state) {
              logger.d(state.orderStatus);
              final cubit = context.read<FindAndChatWithDriverCubit>();
              return statusToNumber[state.orderStatus] == null ||
                      statusToNumber[state.orderStatus]! >= 1
                  ? const SizedBox.shrink()
                  : BackgroundProfileWidget(
                      child: MyButton(
                        title: S.of(context).editOffer,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: cubit,
                              child: EditOfferDialogWidget(
                                orderId: orderId,
                                offerId: offerId,
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
    );
  }
}
