import 'package:obourkom_driver/core/utils/constant.dart';

import '../../../../core/functions/calculate_distance.dart';

class FirebaseOrderModel {
  final double toLat;
  final String driverId;
  final String code;
  final double priceFrom;
  final double fromLng;
  final String acceptedOfferId;
  final double priceTo;
  final String truckSizeId;
  final String createdAt;
  final String toAddress;
  final String paymentType;
  final String updatedAt;
  final String truckTypeId;
  final double toLng;
  final int id;
  final String notes;
  final int customerId;
  final String typeService;
  final String fromAddress;
  final String status;
  final double fromLat;
  double tripDistance = 0.0;
  double distanceBetweenDriverAndPickup = 0.0;
  double distanceBetweenDriverAndDropOff = 0.0;

  FirebaseOrderModel({
    required this.notes,
    required this.toLat,
    required this.driverId,
    required this.code,
    required this.priceFrom,
    required this.fromLng,
    required this.acceptedOfferId,
    required this.priceTo,
    required this.truckSizeId,
    required this.createdAt,
    required this.toAddress,
    required this.paymentType,
    required this.updatedAt,
    required this.truckTypeId,
    required this.toLng,
    required this.id,
    required this.customerId,
    required this.typeService,
    required this.fromAddress,
    required this.status,
    required this.fromLat,
    required this.tripDistance,
    required this.distanceBetweenDriverAndPickup,
    required this.distanceBetweenDriverAndDropOff,
  });

  factory FirebaseOrderModel.fromJson(
    Map<String, dynamic> json,
    double userLat,
    double userLng,
  ) {
    final distanceBetweenDriverAndPickup = calculateDistance(
      lat1: userLat,
      lon1: userLng,
      lat2: (json['from_lat'] as num).toDouble(),
      lon2: (json['from_lng'] as num).toDouble(),
    )/1000;
    final distanceBetweenDriverAndDropOff = calculateDistance(
      lat1: userLat,
      lon1: userLng,
      lat2: (json['to_lat'] as num).toDouble(),
      lon2:( json['to_lng'] as num).toDouble(),
    )/1000;
    final tripDistance = calculateDistance(
      lat1: (json['from_lat'] as num).toDouble(),
      lon1: (json['from_lng'] as num).toDouble(),
      lat2: (json['to_lat'] as num).toDouble(),
      lon2: (json['to_lng'] as num).toDouble(),
    )/1000;
    logger.i(tripDistance);
    logger.i(distanceBetweenDriverAndDropOff);
    logger.i(distanceBetweenDriverAndPickup);
    return FirebaseOrderModel(
      toLat: (json['to_lat'] as num).toDouble(),
      driverId: json['driver_id'] ?? '',
      code: json['code'] ?? '',
      priceFrom: (json['price_from'] as num).toDouble(),
      fromLng: (json['from_lng'] as num).toDouble(),
      acceptedOfferId: json['accepted_offer_id'] ?? '',
      priceTo: (json['price_to'] as num).toDouble(),
      truckSizeId: json['truck_size_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      toAddress: json['to_address'] ?? '',
      paymentType: json['payment_type'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      truckTypeId: json['truck_type_id'] ?? '',
      toLng: (json['to_lng'] as num).toDouble(),
      id: json['id'] ?? 0,
      customerId: json['customer_id'] ?? 0,
      typeService: json['type_service'] ?? '',
      fromAddress: json['from_address'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      fromLat: (json['from_lat'] as num).toDouble(),
      tripDistance: tripDistance.floorToDouble(),
      distanceBetweenDriverAndPickup: distanceBetweenDriverAndPickup.floorToDouble(),
      distanceBetweenDriverAndDropOff: distanceBetweenDriverAndDropOff.floorToDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to_lat': toLat,
      'driver_id': driverId,
      'code': code,
      'price_from': priceFrom,
      'from_lng': fromLng,
      'accepted_offer_id': acceptedOfferId,
      'price_to': priceTo,
      'truck_size_id': truckSizeId,
      'created_at': createdAt,
      'to_address': toAddress,
      'payment_type': paymentType,
      'updated_at': updatedAt,
      'truck_type_id': truckTypeId,
      'to_lng': toLng,
      'id': id,
      'customer_id': customerId,
      'type_service': typeService,
      'from_address': fromAddress,
      'status': status,
      'from_lat': fromLat,
    };
  }
}
