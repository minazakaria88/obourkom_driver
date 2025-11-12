class DriverServicesModel {
  final bool status;
  final String message;
  final List<DriverServiceData> data;

  DriverServicesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverServicesModel.fromJson(Map<String, dynamic> json) {
    return DriverServicesModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DriverServiceData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class DriverServiceData {
  final int id;
  final String brand;
  final String model;
  final int typeId;
  final int sizeId;
  final String? otherService;
  final List<String> categoryIds;
  final List<String> categories;

  DriverServiceData({
    required this.id,
    required this.brand,
    required this.model,
    required this.typeId,
    required this.sizeId,
    this.otherService,
    required this.categoryIds,
    required this.categories,
  });

  factory DriverServiceData.fromJson(Map<String, dynamic> json) {
    return DriverServiceData(
      id: json['id'] ?? 0,
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      typeId: json['type_id'] ?? 0,
      sizeId: json['size_id'] ?? 0,
      otherService: json['other_service'],
      categoryIds: (json['category_ids'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      categories:
      (json['categories'] as List?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'brand': brand,
    'model': model,
    'type_id': typeId,
    'size_id': sizeId,
    'other_service': otherService,
    'category_ids': categoryIds,
    'categories': categories,
  };
}
