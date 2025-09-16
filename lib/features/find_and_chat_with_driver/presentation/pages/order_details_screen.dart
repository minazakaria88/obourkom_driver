import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/send_image_widget.dart';
import 'package:obourkom_driver/features/profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/data/models/submit_order_model.dart';
import '../cubit/find_and_chat_with_driver_cubit.dart';
import '../widgets/finding_driver_widgets/order_details_widget.dart';
import '../widgets/order_details_widget/call_and_chat_with_user.dart';
import '../widgets/order_details_widget/chat_listview.dart';
import '../widgets/order_details_widget/order_status_widget.dart';
import '../widgets/order_details_widget/send_message_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderModel});
  final SubmitOrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FindAndChatWithDriverCubit>();
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).orderDetails,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.imagesQuestionCircle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: 20.height),
                  const OrderStatusWidget(),
                  SliverToBoxAdapter(child: 20.height),
                  SliverToBoxAdapter(
                    child: OrderDetailsWidget(model: orderModel),
                  ),
                  SliverToBoxAdapter(child: 20.height),
                  // const EditOfferWidget(),
                  CallAndChatWithUser(
                    cubit: cubit,
                    userPhone: orderModel.userPhone ?? '',
                    orderId: orderModel.id.toString(),
                    userName: orderModel.userName ?? '',
                  ),
                  SliverToBoxAdapter(child: 20.height),
                  SliverToBoxAdapter(
                    child: BackgroundProfileWidget(
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.imagesLocation),
                          10.width,
                          Column(
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
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: 20.height),
                  BlocBuilder<
                    FindAndChatWithDriverCubit,
                    FindAndChatWithDriverState
                  >(
                    buildWhen: (previous, current) =>
                        previous.orderStatus != current.orderStatus,
                    builder: (context, state) {
                      return state.orderStatus == null ||
                              statusToNumber[state.orderStatus] == 0
                          ? const ChatListview()
                          : const SliverToBoxAdapter(
                              child: SizedBox(height: 250),
                            );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
              buildWhen: (previous, current) =>
                  previous.orderStatus != current.orderStatus,
              builder: (context, state) {
                return state.orderStatus == null ||
                        statusToNumber[state.orderStatus] == 0
                    ? SafeArea(
                        child: SendMessageWidget(
                          cubit: cubit,
                          orderId: orderModel.id.toString(),
                          driverId: CacheHelper.getData(
                            key: CacheHelperKeys.customerId,
                          ).toString(),
                        ),
                      )
                    : SendImageWidget(orderId: orderModel.id.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
