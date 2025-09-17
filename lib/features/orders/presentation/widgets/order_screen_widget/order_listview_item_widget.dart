import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:obourkom_driver/core/utils/constant.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/models/offer_model.dart';
import 'package:obourkom_driver/features/orders/data/models/order_adapter_model.dart';
import 'package:obourkom_driver/features/orders/data/models/order_model.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../find_and_chat_with_driver/presentation/widgets/finding_driver_widgets/order_details_item_widget.dart';
import '../../../../profile/presentation/widgets/profile_screen_widgets/background_profile_widget.dart';

class OrderListviewItemWidget extends StatelessWidget {
  const OrderListviewItemWidget({super.key, required this.model});

  final OrderDataModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(model.status=='delivered'){
          context.pushNamed(
            Routes.completedOrderDetails,
            arguments: model
          );
        }
        else if(model.status=='available')
          {
            context.pushNamed(
              Routes.addOfferScreen,
              arguments: OrderAdapterModel.fromOrderModel(model),
            );
          }
        else
          {
            if(model.offers==null||model.offers!.isEmpty){
              return;
            }
            Offer offer= model.offers!.where((e)=>e.id==model.acceptedOfferId).first;
            logger.i(offer.driverId);
            if(offer.driverId!=CacheHelper.getData(key: CacheHelperKeys.customerId)) {
              return;
            }
            context.pushNamed(
              Routes.orderDetails,
              arguments: {
                'order':OrderAdapterModel.fromOrderModel(model),
                'driver': OfferModel(
                  driverId: offer.driverId,
                  name: model.driver?.name ??'',
                  price: offer.price,
                ),
              },
            );
          }

      },
      child: BackgroundProfileWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        10.width,
                        SvgPicture.asset(
                          model.status != 'delivered'
                              ? Assets.imagesPending
                              : Assets.imagesProfile,
                        ),
                        10.width,
                        Text(
                          S.of(context).pending,
                          style: AppTextStyles.bold18Black,
                        ),
                      ],
                    ),
                    const Divider(thickness: 2, color: Colors.grey),
                    OrderDetailsItemWidget(
                      value: '#${model.id}',
                      title: S.of(context).orderNumber,
                    ),
                    OrderDetailsItemWidget(
                      value: model.typeService ?? '',
                      title: S.of(context).serviceType,
                    ),
                    OrderDetailsItemWidget(
                      value: model.truckSize!.name  ?? '',
                      title: S.of(context).carType,
                    ),
                    OrderDetailsItemWidget(
                      value: model.price ?? '',
                      title: S.of(context).total,
                    ),
                  ],
                ),
              ),
              10.width,
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
