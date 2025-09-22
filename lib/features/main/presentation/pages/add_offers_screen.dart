import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/functions/show_snack_bar.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import 'package:obourkom_driver/features/main/presentation/widgets/main_widget.dart';
import 'package:obourkom_driver/features/orders/data/models/order_adapter_model.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../widgets/add_offers_widgets/add_offer_button.dart';
import '../widgets/add_offers_widgets/add_offer_disaplw_widget.dart';
import '../widgets/add_offers_widgets/selected_order_details.dart';

class AddOffersScreen extends StatelessWidget {
  const AddOffersScreen({super.key, required this.model});
  final FirebaseOrderModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).details),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SelectedOrderDetails(model: model)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocConsumer<MainCubit, MainState>(
              listenWhen: (previous, current) =>
                  previous.sendOfferState != current.sendOfferState ||
                  previous.offer != current.offer,
              listener: (context, state) {
                if (state.isSendOfferFail) {
                  showToastification(
                    message: state.errorMessage ?? '',
                    context: context,
                    type: ToastificationType.error,
                  );
                }
                if (state.offer?.isAccepted == true) {
                  showToastification(
                    message: S.of(context).offerAccepted,
                    context: context,
                    type: ToastificationType.success,
                  );
                  context.pushReplacementNamed(
                    Routes.orderDetails,
                    arguments: {
                      'order': OrderAdapterModel.fromFirebaseOrderModel(model),
                    },
                  );
                }
                if (state.offer?.status == 'cancelled') {
                  showToastification(
                    message: S.of(context).offerRejected,
                    context: context,
                    type: ToastificationType.warning,
                  );
                  if(context.mounted)
                  {
                    if(Navigator.of(context).canPop()) {
                      context.pop();
                    }
                  }
                }
              },
              builder: (context, state) {
                return state.isSendOfferSuccess
                    ? MainWidget(
                        text1: S.of(context).waitingForReply,
                        text2: S.of(context).offerSubmittedAndWaitingForReply,
                        image: Assets.imagesWaiting,
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
        buildWhen: (previous, current) =>
            previous.sendOfferState != current.sendOfferState,
        builder: (context, state) {
          return state.sendOfferState == SendOfferState.success
              ? const AddOfferDisableWidget()
              :  AddOfferButton(offerId: model.id.toString(),);
        },
      ),
    );
  }
}
