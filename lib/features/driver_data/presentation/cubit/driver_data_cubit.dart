import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_brand_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_type_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/categories_model.dart';
import 'package:obourkom_driver/features/driver_data/data/repositories/driver_data_repo.dart';
import 'package:obourkom_driver/features/find_and_chat_with_driver/data/repositories/find_and_chat_repo.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
import '../../../find_and_chat_with_driver/data/models/image_model.dart';
import '../../data/models/car_model.dart';
import '../../data/models/car_size_model.dart';
import 'package:path/path.dart' as path;

part 'driver_data_state.dart';

class DriverDataCubit extends Cubit<DriverDataState> {
  DriverDataCubit({
    required this.findAndChatWithDriverRepository,
    required this.driverDataRepo,
  }) : super(const DriverDataState());

  final DriverDataRepo driverDataRepo;
  final FindAndChatWithDriverRepository findAndChatWithDriverRepository;

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

  dynamic getCarData() async {
    final Map<String, dynamic> data = {
      'type_id': state.selectedCarTypeId.toString(),
      'brand_id': state.selectedCarBrandId.toString(),
      'size_id': state.selectedCarSizeId.toString(),
      'model_id': state.selectedCarModelId.toString(),
    };
    final results = await Future.wait([
   if( state.driverLicenseImage!=null)
     uploadImages(
        image: state.driverLicenseImage!,
        collection: 'driver_license',
      ),
      if( state.carLicenseImage!=null)
        uploadImages(
        image: state.carLicenseImage!,
        collection: 'car_license',
      ),
      if( state.driverNationalIdImage!=null)
        uploadImages(
        image: state.driverNationalIdImage!,
        collection: 'national_id',
      ),
    ]);



    if( state.driverLicenseImage!=null) {
      data['driver_license'] = results[0].token;
    }
    if( state.carLicenseImage!=null) {
      data['car_license'] = results[1].token;
    }
    if( state.driverNationalIdImage!=null) {
      data['national_id'] = results[2].token;
    }
    int mainIndex = 0;
    int otherIndex = 0;
    for (var e in state.selectedCategories!) {
      if (e.id == null) {
        data['other_service[$otherIndex]'] = e.name ?? '';

        otherIndex++;
      } else {
        data['category_id[$mainIndex]'] = e.id;

        mainIndex++;
      }
    }

    logger.d(data);
    return data;
  }

  void sendCarData() async {
    try {
      emit(state.copyWith(sendDriverDataStatus: SendDriverDataStatus.loading));
      final data = await getCarData();
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

  Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (photo != null) {
      final ext = path.extension(photo.path);
      final tempDir = await getTemporaryDirectory();
      final savedImage = File(
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}$ext',
      );
      await File(photo.path).copy(savedImage.path);
      logger.f(savedImage.path);
      return savedImage.path;
    }
    return null;
  }

  void pickDriverLicense() async {
    final image = await pickImage();
    if (image != null) {
      emit(state.copyWith(driverLicenseImage: image));
    }
  }

  void pickCarLicenseImage() async {
    final image = await pickImage();
    if (image != null) {
      emit(state.copyWith(carLicenseImage: image));
    }
  }

  void pickNationalIdImage() async {
    final image = await pickImage();
    if (image != null) {
      emit(state.copyWith(driverNationalIdImage: image));
    }
  }

  Future<ImageModel> uploadImages({
    required String image,
    required String collection,
  }) async {
    return await findAndChatWithDriverRepository.uploadImage(
      image: image,
      collection: collection,
    );
  }

  @override
  Future<void> close() {
    serviceController.dispose();
    return super.close();
  }
}
