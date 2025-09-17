import '../../../../core/functions/calculate_distance.dart';

class FirebaseOrderModel {
  String? phoneCustomer;
  String? nameTruckSize;
  String? code;
  String? notes;
  String? nameDriver;
  double? fromLng;
  String? acceptedOfferId;
  int? idCustomer;
  String? nameTruckType;
  String? createdAt;
  String? updatedAt;
  double? toLng;
  int? id;
  String? phoneDriver;
  String? fromAddress;
  String? idDriver;
  double? fromLat;
  double? toLat;
  double? priceFrom;
  int? idTruckType;
  double? priceTo;
  String? toAddress;
  String? nameCustomer;
  String? paymentType;
  int? idTruckSize;
  String? typeService;
  String? status;
  double tripDistance = 0.0;
  double distanceBetweenDriverAndPickup = 0.0;
  double distanceBetweenDriverAndDropOff = 0.0;

  FirebaseOrderModel({
    this.phoneCustomer,
    this.nameTruckSize,
    this.code,
    this.notes,
    this.nameDriver,
    this.fromLng,
    this.acceptedOfferId,
    this.idCustomer,
    this.nameTruckType,
    this.createdAt,
    this.updatedAt,
    this.toLng,
    this.id,
    this.phoneDriver,
    this.fromAddress,
    this.idDriver,
    this.fromLat,
    this.toLat,
    this.priceFrom,
    this.idTruckType,
    this.priceTo,
    this.toAddress,
    this.nameCustomer,
    this.paymentType,
    this.idTruckSize,
    this.typeService,
    this.status,
    this.tripDistance = 0.0,
    this.distanceBetweenDriverAndPickup = 0.0,
    this.distanceBetweenDriverAndDropOff = 0.0,
  });

  FirebaseOrderModel.fromJson(
    Map<String, dynamic> json,
    double userLat,
    double userLng,
  ) {
    final distanceBetweenDriverAndPickupValue = calculateDistance(
      lat1: userLat,
      lon1: userLng,
      lat2: (json['from_lat'] as num).toDouble(),
      lon2: (json['from_lng'] as num).toDouble(),
    )/1000;
    final distanceBetweenDriverAndDropOffValue = calculateDistance(
      lat1: userLat,
      lon1: userLng,
      lat2: (json['to_lat'] as num).toDouble(),
      lon2:( json['to_lng'] as num).toDouble(),
    )/1000;
    final tripDistanceValue = calculateDistance(
      lat1: (json['from_lat'] as num).toDouble(),
      lon1: (json['from_lng'] as num).toDouble(),
      lat2: (json['to_lat'] as num).toDouble(),
      lon2: (json['to_lng'] as num).toDouble(),
    )/1000;
    phoneCustomer = json['phone_customer'];
    nameTruckSize = json['name_truckSize'];
    code = json['code'];
    notes = json['notes'];
    nameDriver = json['name_driver'];
    fromLng = json['from_lng'];
    acceptedOfferId = json['accepted_offer_id'];
    idCustomer = json['id_customer'];
    nameTruckType = json['name_truckType'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    toLng = json['to_lng'];
    id = json['id'];
    phoneDriver = json['phone_driver'];
    fromAddress = json['from_address'];
    idDriver = json['id_driver'];
    fromLat = json['from_lat'];
    toLat = json['to_lat'];
    priceFrom = json['price_from'];
    idTruckType = json['id_truckType'];
    priceTo = json['price_to'];
    toAddress = json['to_address'];
    nameCustomer = json['name_customer'];
    paymentType = json['payment_type'];
    idTruckSize = json['id_truckSize'];
    typeService = json['type_service'];
    status = json['status'];
    tripDistance= tripDistanceValue.floorToDouble();
    distanceBetweenDriverAndPickup= distanceBetweenDriverAndPickupValue.floorToDouble();
    distanceBetweenDriverAndDropOff= distanceBetweenDriverAndDropOffValue.floorToDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_customer'] = phoneCustomer;
    data['name_truckSize'] = nameTruckSize;
    data['code'] = code;
    data['notes'] = notes;
    data['name_driver'] = nameDriver;
    data['from_lng'] = fromLng;
    data['accepted_offer_id'] = acceptedOfferId;
    data['id_customer'] = idCustomer;
    data['name_truckType'] = nameTruckType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['to_lng'] = toLng;
    data['id'] = id;
    data['phone_driver'] = phoneDriver;
    data['from_address'] = fromAddress;
    data['id_driver'] = idDriver;
    data['from_lat'] = fromLat;
    data['to_lat'] = toLat;
    data['price_from'] = priceFrom;
    data['id_truckType'] = idTruckType;
    data['price_to'] = priceTo;
    data['to_address'] = toAddress;
    data['name_customer'] = nameCustomer;
    data['payment_type'] = paymentType;
    data['id_truckSize'] = idTruckSize;
    data['type_service'] = typeService;
    data['status'] = status;
    return data;
  }
}
