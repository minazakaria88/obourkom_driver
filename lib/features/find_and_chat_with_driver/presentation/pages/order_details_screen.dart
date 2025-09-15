import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/core/widgets/my_button.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/send_image_widget.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/data/models/submit_order_model.dart';
import '../cubit/find_and_chat_with_driver_cubit.dart';
import '../widgets/finding_driver_widgets/order_details_widget.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 80,
              ), // space for input field
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: 20.height),
                  const OrderStatusWidget(),
                  SliverToBoxAdapter(child: 20.height),
                  SliverToBoxAdapter(
                    child: OrderDetailsWidget(model: orderModel),
                  ),
                  SliverToBoxAdapter(child: 10.height),
                  const EditOfferWidget(),
                  SliverToBoxAdapter(child: 10.height),
                  SliverToBoxAdapter(
                    child: SendImageWidget(orderId: orderModel.id.toString()),
                  ),
                  SliverToBoxAdapter(child: 10.height),
                 // const SliverToBoxAdapter(child: DriverDetails()),
                  SliverToBoxAdapter(child: 20.height),
                  const ChatListview(),
                  SliverToBoxAdapter(child: 20.height),
                ],
              ),
            ),
            SendMessageWidget(
              cubit: cubit,
              orderId: orderModel.id.toString(),
              driverId: CacheHelper.getData(
                key: CacheHelperKeys.customerId,
              ).toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class EditOfferWidget extends StatelessWidget {
  const EditOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child:
          BlocConsumer<FindAndChatWithDriverCubit, FindAndChatWithDriverState>(
            listener: (context, state) {},
            builder: (context, state) {
              logger.d(state.orderStatus);
              return statusToNumber[state.orderStatus]==null || statusToNumber[state.orderStatus]! >= 1
                  ? const SizedBox.shrink()
                  : MyButton(title: S.of(context).editOffer, onTap: () {});
            },
          ),
    );
  }
}
