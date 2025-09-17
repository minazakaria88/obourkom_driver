import 'package:obourkom_driver/features/orders/data/models/order_model.dart';
import 'package:obourkom_driver/features/orders/data/models/submit_order_model.dart';

import '../../../main/data/models/firebase_order_model.dart';

class OrderAdapterModel {
  static SubmitOrderModel fromOrderModel(OrderDataModel model) {
    return SubmitOrderModel(
      id: model.id,
      fromLat: model.fromLat,
      fromLng: model.fromLng,
      toLat: model.toLat,
      toLng: model.toLng,
      paymentType: model.paymentType,
      notes: model.notes,
      code: model.code,
      truckTypeId: model.truckType?.name.toString(),
      truckSizeId: model.truckSize?.name.toString(),
      priceTo: double.tryParse(model.priceTo ?? ''),
      priceFrom: double.tryParse(model.priceFrom ?? ''),
      typeService: model.typeService,
      userName: model.customer?.name ?? '',
      status: model.status,
      addressFrom: model.fromAddress,
      addressTo: model.toAddress,
      createdAt: model.createdAt,
    );
  }


  static SubmitOrderModel fromFirebaseOrderModel(FirebaseOrderModel model) {
    return SubmitOrderModel(
      id: model.id,
      typeService: model.typeService,
      status: model.status,
      truckSizeId: model.nameTruckSize,
      truckTypeId: model.idTruckType.toString(),
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
      userPhone: model.phoneCustomer,
      userName: model.nameCustomer,
      createdAt: model.createdAt,
      customerId: model.idCustomer,
    );
  }


}
