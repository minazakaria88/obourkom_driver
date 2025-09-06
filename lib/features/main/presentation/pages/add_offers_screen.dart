import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/functions/show_snack_bar.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import 'package:obourkom_driver/features/main/presentation/widgets/main_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../find_and_chat_with_driver/data/models/offer_model.dart';
import '../../../orders/data/models/submit_order_model.dart';
import '../widgets/add_offers_widgets/add_offer_button.dart';
import '../widgets/order_location_details.dart';
import '../widgets/order_main_widget.dart';

class AddOffersScreen extends StatelessWidget {
  const AddOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: S.of(context).details),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SelectedOrderDetails()),
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
                      'order': SubmitOrderModel(id: int.parse(state.order!)),
                      'driver': OfferModel(),
                    },
                  );
                }
                if (state.isSendOfferFail) {
                  showToastification(
                    message: state.errorMessage??'',
                    context: context,
                    type: ToastificationType.error,
                  );
                }
              },
              builder: (context, state) {
                return state.isSendOfferSuccess
                    ? const MainWidget(
                        text1: 'في انتظار الرد',
                        text2: 'تم ارسال العرض للعميل وفي انتظار الرد',
                        image: Assets.imagesWaiting,
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AddOfferButton(),
    );
  }
}

class SelectedOrderDetails extends StatelessWidget {
  const SelectedOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(
            S.of(context).details,
            style: AppTextStyles.bold18Black.copyWith(fontSize: 16),
          ),
          backgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.all(10),
          children: [
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            OrderMainWidget(
              image: Assets.imagesDocuments,
              title: S.of(context).orderNumber,
              value: '#51',
            ),
            20.height,
            OrderMainWidget(
              image: Assets.imagesServicesType,
              title: S.of(context).serviceType,
              value: 'نقل أثاث',
            ),
            20.height,
            OrderMainWidget(
              title: S.of(context).tripDistance,
              value: '21 كم',
              image: Assets.imagesTripDistance,
            ),
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            const OrderLocationDetails(),
            10.height,
            const Divider(color: Colors.grey, height: 1.2),
            10.height,
            Text(S.of(context).notes, style: AppTextStyles.bold14Grey),
            10.height,
            const Text(
              'تفاصيل الطلب مثال للنص يكتب هنا في هذه المساحة او اكثر اذا تطلب الأمر، تفاصيل الطلب مثال للنص يكتب هنا في هذه المساحة او اكثر اذا تطلب الأمر، تفاصيل الطلب مثال للنص يكتب هنا في هذه المساحة او اكثر اذا تطلب الأمر، تفاصيل الطلب مثال للنص يكتب هنا في هذه المساحة او اكثر اذا تطلب الأمر، تفاصيل الطلب مثال للنص يكتب هنا في هذه المساحة او اكثر اذا تطلب الأمر، ',
            ),
          ],
        ),
      ),
    );
  }
}
