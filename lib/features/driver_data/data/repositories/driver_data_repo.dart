import 'package:dio/dio.dart';
import 'package:obourkom_driver/core/api/api_helper.dart';

import '../../../../core/api/end_point.dart';
import '../../../../core/api/failure.dart';
import '../../../../core/utils/constant.dart';
import '../models/categories_model.dart';

class DriverDataRepo
{
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
}