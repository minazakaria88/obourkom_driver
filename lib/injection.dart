import 'package:get_it/get_it.dart';
import 'package:obourkom_driver/features/driver_data/data/repositories/driver_data_repo.dart';
import 'package:obourkom_driver/features/driver_data/presentation/cubit/driver_data_cubit.dart';
import 'core/api/api_helper.dart';
import 'features/find_and_chat_with_driver/data/repositories/find_and_chat_repo.dart';
import 'features/find_and_chat_with_driver/presentation/cubit/find_and_chat_with_driver_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/language/presentation/cubit/language_cubit.dart';
import 'features/login/data/repositories/login_repo.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/main/data/repositories/main_repo.dart';
import 'features/main/presentation/cubit/main_cubit.dart';
import 'features/notification/data/repositories/notification_repo.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';
import 'features/orders/data/repositories/order_repo.dart';
import 'features/orders/presentation/cubit/orders_cubit.dart';
import 'features/otp/data/repositories/otp_repo.dart';
import 'features/otp/presentation/cubit/otp_cubit.dart';
import 'features/profile/data/repositories/profile_repo.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/register/data/repositories/register_repo.dart';
import 'features/register/presentation/cubit/register_cubit.dart';

final getIt = GetIt.instance;

void setupServicesLocator() {
  //lang
  getIt.registerFactory(() => LanguageCubit());

  //api
  getIt.registerLazySingleton(() => ApiHelper());


  //login
  getIt.registerFactory(() => LoginCubit(loginRepository: getIt()));
  getIt.registerLazySingleton(() => LoginRepository(apiHelper: getIt()));


  //register
  getIt.registerFactory(() => RegisterCubit(registerRepository: getIt()));
  getIt.registerLazySingleton(() => RegisterRepository(apiHelper: getIt()));


  //otp
  getIt.registerFactory(() => OtpCubit(otpRepository: getIt()));
  getIt.registerLazySingleton(()=>OtpRepository(apiHelper: getIt()));


  //home
  getIt.registerFactory(()=>HomeCubit());


  //main
  getIt.registerFactory(() => MainCubit(mainRepository: getIt()));
  getIt.registerLazySingleton(() => MainRepository(apiHelper: getIt()));

  //notifications
  getIt.registerFactory(() => NotificationCubit(notificationRepository: getIt()));
  getIt.registerLazySingleton(()=>NotificationRepository(apiHelper: getIt()));


  //orders
  getIt.registerFactory(() => OrdersCubit(orderRepository: getIt()));
  getIt.registerLazySingleton(()=>OrderRepository(apiHelper: getIt()));


  //Profile
  getIt.registerFactory(() => ProfileCubit(profileRepository: getIt()));
  getIt.registerLazySingleton(() => ProfileRepository(apiHelper: getIt()));





  //findAndChatWithDriver
  getIt.registerFactory(() => FindAndChatWithDriverCubit(findAndChatWithDriverRepository: getIt()));
  getIt.registerLazySingleton(() => FindAndChatWithDriverRepository(apiHelper: getIt()));


  //driverData

  getIt.registerFactory(()=>DriverDataCubit(driverDataRepo: getIt()));
  getIt.registerLazySingleton(()=>DriverDataRepo(apiHelper: getIt()));


}
