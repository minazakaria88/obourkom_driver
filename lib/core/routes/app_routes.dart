import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/cache_helper.dart';
import 'package:obourkom_driver/core/routes/routes.dart';
import 'package:obourkom_driver/features/main/presentation/cubit/main_cubit.dart';
import 'package:obourkom_driver/features/main/presentation/pages/add_offers_screen.dart';
import '../../features/find_and_chat_with_driver/data/models/offer_model.dart';
import '../../features/find_and_chat_with_driver/presentation/cubit/find_and_chat_with_driver_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/notification/presentation/pages/notification_screen.dart';
import '../../features/orders/data/models/order_model.dart';
import '../../features/orders/data/models/submit_order_model.dart';
import '../../features/orders/presentation/pages/completed_order_details_screen.dart';
import '../../features/find_and_chat_with_driver/presentation/pages/order_details_screen.dart';
import '../../features/otp/presentation/cubit/otp_cubit.dart';
import '../../features/otp/presentation/pages/otp_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/profile/presentation/pages/profile_features_screens/about_us_screen.dart';
import '../../features/profile/presentation/pages/profile_features_screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/pages/profile_features_screens/support_screen.dart';
import '../../features/profile/presentation/pages/profile_features_screens/terms_and_conditions_screen.dart';
import '../../features/register/presentation/cubit/register_cubit.dart';
import '../../features/register/presentation/pages/register_screen.dart';
import '../../injection.dart';
import '../helpers/error_handler.dart';
import '../utils/constant.dart';
import '../widgets/no_internet_screen.dart';

class AppRoues {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.otp:
        final arguments = setting.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OtpCubit>()..startTimerDuration(),
            child: OtpScreen(
              otpType: arguments['otpType'],
              phoneNumber: arguments['phone'],
            ),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );
      case Routes.editProfile:
        final arguments = setting.arguments as ProfileCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: arguments,
            child: const EditProfileScreen(),
          ),
        );

      case Routes.notifications:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case Routes.support:
        return MaterialPageRoute(builder: (context) => const SupportScreen());
      case Routes.aboutUs:
        final arguments = setting.arguments as ProfileCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: arguments..getFaq(),
            child: const AboutUsScreen(),
          ),
        );
      case Routes.termsAndConditions:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditionsScreen(),
        );
      case Routes.privacyPolicy:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen(),
        );
      case Routes.orderDetails:
        final arguments = setting.arguments as Map<String, dynamic>;
        final order = arguments['order'] as SubmitOrderModel;
        final driverId=CacheHelper.getData(key: CacheHelperKeys.customerId);
        logger.i(order.id);
        logger.i(driverId);
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<FindAndChatWithDriverCubit>()
              ..listenForMessages(
                driverId: driverId.toString(),
                orderId: order.id.toString(),
              )
              ..listenForOrderStatus(orderId: order.id.toString()),
            child: OrderDetailsScreen(orderModel: order,),
          ),
        );
      case Routes.completedOrderDetails:
        final arguments = setting.arguments as OrderDataModel;
        return MaterialPageRoute(
          builder: (context) => CompletedOrderDetailsScreen(model: arguments),
        );
      case Routes.noInternet:
        return MaterialPageRoute(builder: (context) => const NoInternet());
      case Routes.error:
        final arguments = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CustomErrorWidget(error: arguments),
        );
      case Routes.addOfferScreen:
        final arguments = setting.arguments as MainCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: arguments,
            child: const AddOffersScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
