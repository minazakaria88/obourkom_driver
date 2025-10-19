import 'package:dio/dio.dart';
import 'package:obourkom_driver/core/api/api_helper.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_brand_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_size_model.dart';
import 'package:obourkom_driver/features/driver_data/data/models/car_type_model.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
import '../models/categories_model.dart';

class DriverDataRepo {
  final ApiHelper apiHelper;

  DriverDataRepo({required this.apiHelper});

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await apiHelper.getData(url: EndPoints.categories);
      logger.d(response.data);
      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<CarModel> getCarModel() async {
    try {
      final response = await apiHelper.getData(url: EndPoints.truckModel);
      logger.i(response);
      return CarModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<CarBrandModel> getCarBrandModel() async {
    try {
      final response = await apiHelper.getData(url: EndPoints.truckBrand);
      logger.i(response);
      return CarBrandModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<CarSizeModel> getCarSizeModel() async {
    try {
      final response = await apiHelper.getData(url: EndPoints.trucksSize);
      logger.i(response);
      return CarSizeModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<CarTypeModel> getCarTypeModel() async {
    try {
      final response = await apiHelper.getData(url: EndPoints.truckType);
      logger.i(response);
      return CarTypeModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }

  Future<void> sendDriverData(data) async {
    try {
      final response = await apiHelper.postData(url: EndPoints.cars, data: data,options: Options(
        contentType: Headers.formUrlEncodedContentType
      ));
      logger.i(response);
    } catch (e) {
      logger.e(e);
      if (e is DioException) {
        throw ApiException(failure: ServerFailure.serverError(e));
      }
      throw ApiException(failure: Failure(message: e.toString()));
    }
  }



}
