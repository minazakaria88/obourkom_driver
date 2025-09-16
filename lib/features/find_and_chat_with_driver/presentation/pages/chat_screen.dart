import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/widgets/my_app_bar.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/presentation/widgets/order_details_widget/chat_listview.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../generated/l10n.dart';
import '../cubit/find_and_chat_with_driver_cubit.dart';
import '../widgets/order_details_widget/send_message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.orderId});
   final String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).chat),
      body:  Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0, top: 12.0, left: 12, right: 12),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: 20.height),
                const ChatListview(),
              ],
            ),
          ),
          SendMessageWidget(
            cubit: context.read<FindAndChatWithDriverCubit>(),
            orderId: orderId,
            driverId: CacheHelper.getData(
              key: CacheHelperKeys.customerId,
            ).toString(),
          ),
        ],
      ),

    );
  }
}
