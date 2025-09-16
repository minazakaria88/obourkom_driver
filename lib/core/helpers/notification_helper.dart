import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:obourkom_driver/core/utils/constant.dart';

class NotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    logger.i(settings.authorizationStatus);
  }


}
