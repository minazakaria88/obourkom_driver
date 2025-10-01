import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/l10n.dart';
import 'add_offer_widget.dart';

class AddOfferButton extends StatelessWidget {
  const AddOfferButton({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 0),
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.height,
            MyButton(
              title: S.of(context).addOffer,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: context.read<MainCubit>(),
                    child:  AddOfferWidget(orderId: orderId,),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
