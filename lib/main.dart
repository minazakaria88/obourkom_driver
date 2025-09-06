import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:obourkom_driver/core/helpers/extension.dart';
import 'package:toastification/toastification.dart';
import 'bloc_observer.dart';
import 'core/api/api_helper.dart';
import 'core/helpers/cache_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/routes.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/constant.dart';
import 'features/language/presentation/cubit/language_cubit.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'injection.dart';

bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // FlutterError.onError = ErrorHandler.handleFlutterError;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  ApiHelper.init();
  await checkIfUserLoggedIn();
  setupServicesLocator();
  Bloc.observer = MyBlocObserver();
  runApp(DevicePreview(enabled: false, builder: (context) => const ObourkomDriver()));
}

class ObourkomDriver extends StatelessWidget {
  const ObourkomDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LanguageCubit>()..initLanguage(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) => ToastificationWrapper(
          child: MaterialApp(
            navigatorKey: NavigatorClass.navigatorKey,
            title: '3bourkomDriver',
            theme: appTheme(),
            locale: Locale(
              CacheHelper.getData(key: CacheHelperKeys.lang) ?? 'en',
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoues.onGenerateRoute,
            initialRoute: isLoggedIn ? Routes.home : Routes.login,
          ),
        ),
      ),
    );
  }
}

class NavigatorClass {
  static final navigatorKey = GlobalKey<NavigatorState>();
}

Future<void> checkIfUserLoggedIn() async {
  String? token = await CacheHelper.getSecureString(CacheHelperKeys.token);
  logger.i(token);
  if (!token.isNullOrEmpty()) {
    isLoggedIn = true;
  }
}

//https://firebase.google.com/docs/crashlytics/get-started?platform=flutter

