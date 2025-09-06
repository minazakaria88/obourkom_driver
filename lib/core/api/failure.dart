import 'package:dio/dio.dart';

import '../../main.dart';
import '../helpers/cache_helper.dart';
import '../routes/routes.dart';
import '../utils/constant.dart';

class ApiException implements Exception {
  Failure failure;

  ApiException({required this.failure});
}

class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.serverError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromCode(e.response!.statusCode, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Unknown Error');
    }
  }

  factory ServerFailure.fromCode(int? code, dynamic response) {
    switch (code) {
      case 400:
      case 403:
      case 422:
        return ServerFailure(message: getError(response));
      case 401:
        return ServerFailure(message: response['message'])..gotoLogin();
      case 404:
        return ServerFailure(message: 'Not Found');
      case 500:
        return ServerFailure(message: 'Internal Server Error');
      case 502:
        return ServerFailure(message: 'Bad Gateway');
      case 503:
        return ServerFailure(message: 'Service Unavailable');
      case 504:
        return ServerFailure(message: 'Gateway Timeout');
      default:
        return ServerFailure(message: 'Something went wrong');
    }
  }

  void gotoLogin() {
    CacheHelper.clearData();
    NavigatorClass.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      Routes.login,
      (context) => false,
    );
  }
}

String getError(dynamic response) {
  logger.i(response);
  String error = '';
  if (response['errors'] == null) {
    if (response['message'] != null) {
      return response['message'];
    } else if (response['error'] != null) {
      return response['error'];
    } else {
      return 'Something went wrong';
    }
  }
  Map<String, dynamic> errors = response['errors'];
  errors.forEach((k, v) {
    error += '${v.first}\n';
  });

  return error;
}
