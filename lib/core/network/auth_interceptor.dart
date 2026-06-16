import 'package:dio/dio.dart';

import '../../main.dart';
import '../routes/routes.dart';
import '../storage/cache_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await CacheHelper.getSecureString(CacheHelperKeys.token);
    final lang = await CacheHelper.getSecureString(CacheHelperKeys.lang);
    options.headers['lang'] = lang;
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      CacheHelper.clearData();
      NavigatorClass.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.login,
        (context) => false,
      );
    }
    handler.next(err);}
}
