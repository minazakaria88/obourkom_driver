import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/find_and_chat_with_driver_cubit.dart';

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
          return statusToNumber[state.orderStatus] == null ||
              statusToNumber[state.orderStatus]! >= 1
              ? const SizedBox.shrink()
              : MyButton(title: S.of(context).editOffer, onTap: () {});
        },
      ),
    );
  }
}
