part of 'driver_data_cubit.dart';

enum GetCategoriesStatus{loading,success,error}


enum SendDriverDataStatus{loading,success,error}

@immutable
class DriverDataState extends Equatable {
  final CategoriesModel? categoriesModel;
  final String? errorMessage;
  final Set<CategoryModel> ? selectedCategories;
  final GetCategoriesStatus ?getCategoriesStatus;
  final CarModel? carModel;
  final CarBrandModel? carBrandModel;
  final CarTypeModel ? carTypeModel;
  final CarSizeModel ? carSizeModel;
  final int ? selectedCarBrandId;
  final int ? selectedCarSizeId;
  final int ? selectedCarTypeId;
  final int ? selectedCarModelId;
  final SendDriverDataStatus ? sendDriverDataStatus;


  const DriverDataState({
    this.categoriesModel,
    this.errorMessage,
    this.selectedCategories,
    this.getCategoriesStatus,
    this.carModel,
    this.carBrandModel,
    this.carTypeModel,
    this.carSizeModel,
    this.selectedCarBrandId,
    this.selectedCarSizeId,
    this.selectedCarTypeId,
    this.selectedCarModelId,
    this.sendDriverDataStatus
  });

  DriverDataState copyWith({
    CategoriesModel? categoriesModel,
    String? errorMessage,
    Set<CategoryModel>? selectedCategories,
    GetCategoriesStatus ? getCategoriesStatus,
    CarModel? carModel,
    CarBrandModel? carBrandModel,
    CarTypeModel ? carTypeModel,
    CarSizeModel ? carSizeModel,
    int ? selectedCarBrandId,
    int ? selectedCarSizeId,
    int ? selectedCarTypeId,
    int ? selectedCarModelId,
    SendDriverDataStatus ? sendDriverDataStatus

  }) {
    return DriverDataState(
      categoriesModel: categoriesModel ?? this.categoriesModel,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      getCategoriesStatus:  getCategoriesStatus ?? this.getCategoriesStatus,
      carModel: carModel ?? this.carModel,
      carBrandModel: carBrandModel ?? this.carBrandModel,
      carTypeModel: carTypeModel ?? this.carTypeModel,
      carSizeModel: carSizeModel ?? this.carSizeModel,
      selectedCarBrandId: selectedCarBrandId ?? this.selectedCarBrandId,
      selectedCarSizeId: selectedCarSizeId ?? this.selectedCarSizeId,
      selectedCarTypeId: selectedCarTypeId ?? this.selectedCarTypeId,
      selectedCarModelId: selectedCarModelId ?? this.selectedCarModelId,
      sendDriverDataStatus: sendDriverDataStatus ?? this.sendDriverDataStatus

    );
  }

  @override
  List<Object?> get props => [
    categoriesModel,
    errorMessage,
    selectedCategories,
    getCategoriesStatus,
    carModel,
    carBrandModel,
    carTypeModel,
    carSizeModel,
    selectedCarBrandId,
    selectedCarSizeId,
    selectedCarTypeId,
    selectedCarModelId,
    sendDriverDataStatus
  ];
}
