import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_brand_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_type_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/categories_model.dart';
import 'package:obourkom_driver/features/driver_data/data/repositories/driver_data_repo.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
import '../../data/models/car_model.dart';
import '../../data/models/car_size_model.dart';
part 'driver_data_state.dart';

class DriverDataCubit extends Cubit<DriverDataState> {
  DriverDataCubit({required this.driverDataRepo})
    : super(const DriverDataState());

  final DriverDataRepo driverDataRepo;

  final TextEditingController serviceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dropDownKey = GlobalKey<FormState>();

  void getCategories() async {
    try {
      emit(state.copyWith(getCategoriesStatus: GetCategoriesStatus.loading));
      final result = await driverDataRepo.getCategories();
      emit(
        state.copyWith(
          categoriesModel: result,
          getCategoriesStatus: GetCategoriesStatus.success,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    }
  }

  void selectCategory(CategoryModel category) {
    final updatedSet = Set<CategoryModel>.from(state.selectedCategories ?? {});
    if (state.selectedCategories?.contains(category) ?? false) {
      updatedSet.remove(category);
      emit(state.copyWith(selectedCategories: updatedSet));
    } else {
      updatedSet.add(category);
      emit(state.copyWith(selectedCategories: updatedSet));
    }
  }

  void addNewService(CategoryModel services) {
    emit(state.copyWith(getCategoriesStatus: GetCategoriesStatus.loading));
    final updateCategories = List<CategoryModel>.from(
      state.categoriesModel?.data ?? [],
    );
    updateCategories.add(services);
    selectCategory(services);
    serviceController.clear();
    emit(
      state.copyWith(
        getCategoriesStatus: GetCategoriesStatus.success,
        categoriesModel: state.categoriesModel?.copyWith(
          data: updateCategories,
        ),
      ),
    );
  }

  void getCarBrands() async {
    try {
      final result = await driverDataRepo.getCarBrandModel();
      emit(state.copyWith(carBrandModel: result));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    }
  }

  void getCarTypes() async {
    try {
      final result = await driverDataRepo.getCarTypeModel();
      emit(state.copyWith(carTypeModel: result));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    }
  }

  void getCarSizes() async {
    try {
      final result = await driverDataRepo.getCarSizeModel();
      emit(state.copyWith(carSizeModel: result));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    }
  }

  void getCarModels() async {
    try {
      final result = await driverDataRepo.getCarModel();
      emit(state.copyWith(carModel: result));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          getCategoriesStatus: GetCategoriesStatus.error,
        ),
      );
    }
  }

  void assignCarModel(int carModel) {
    emit(state.copyWith(selectedCarModelId: carModel));
  }

  void assignCarType(int carType) {
    emit(state.copyWith(selectedCarTypeId: carType));
  }

  void assignCarSize(int carSize) {
    emit(state.copyWith(selectedCarSizeId: carSize));
  }

  void assignCarBrand(int carBrand) {
    emit(state.copyWith(selectedCarBrandId: carBrand));
  }

  dynamic getCarData() {
    final Map<String, dynamic> data={
      'type_id': state.selectedCarTypeId.toString(),
      'brand_id': state.selectedCarBrandId.toString(),
      'size_id': state.selectedCarSizeId.toString(),
      'model_id': state.selectedCarModelId.toString(),
    };
    int mainIndex=0;
    int otherIndex=0;
    for (var e in state.selectedCategories!) {
      if (e.id == null) {
        data['other_service[$otherIndex]']=e.name ??'';

        otherIndex++;
      } else {
        data['category_id[$mainIndex]']=e.id;

        mainIndex++;
      }
    }

    logger.d(data);
    return data;
  }

  void sendCarData() async {
    try {
      emit(state.copyWith(sendDriverDataStatus: SendDriverDataStatus.loading));
      final data = getCarData();
      await driverDataRepo.sendDriverData(data);
      await CacheHelper.saveData(key: CacheHelperKeys.carData, value: 'car');
      emit(state.copyWith(sendDriverDataStatus: SendDriverDataStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.failure.message,
          sendDriverDataStatus: SendDriverDataStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          sendDriverDataStatus: SendDriverDataStatus.error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    serviceController.dispose();
    return super.close();
  }
}
