import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/functions/show_snack_bar.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/data/models/firebase_order_model.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import 'package:obourkom_driver/features/main/presentation/widgets/main_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/data/models/submit_order_model.dart';
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
              listener: (context, state) {
                final id = CacheHelper.getData(
                  key: CacheHelperKeys.customerId,
                ).toString();
                if (state.driverId == id) {
                  context.pushReplacementNamed(
                    Routes.orderDetails,
                    arguments: {
                      'order': SubmitOrderModel(
                        id: int.parse(state.order!),
                        typeService: model.typeService,
                        status: model.status,
                        truckSizeId: model.truckSizeId,
                        truckTypeId: model.truckTypeId,
                        paymentType: model.paymentType,
                        notes: model.notes,
                        addressFrom: model.fromAddress,
                        addressTo: model.toAddress,
                        fromLat: model.fromLat,
                        fromLng: model.fromLng,
                        toLat: model.toLat,
                        toLng: model.toLng,
                        priceFrom: model.priceFrom,
                        priceTo: model.priceTo,
                        code: model.code,
                        userPhone: model.userPhone,
                        userName: model.userName,
                        createdAt: model.createdAt,
                        customerId: model.customerId,
                      ),
                    },
                  );
                }
                if (state.isSendOfferFail) {
                  showToastification(
                    message: state.errorMessage ?? '',
                    context: context,
                    type: ToastificationType.error,
                  );
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
          return state.sendOfferState == SendOfferState.success? const AddOfferDisableWidget(): const AddOfferButton();
        },
      ),
    );
  }
}

