import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/otp/data/models/user_model.dart';
import '../../features/profile/data/models/user_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static late FlutterSecureStorage storage;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is List) {
      return await sharedPreferences.setStringList(key, value as List<String>);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static List<String> getListData({required String key}) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> setSecureString(key, value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String> getSecureString(key) async {
    return await storage.read(key: key) ?? '';
  }

  static clearData() async {
    await storage.deleteAll();
    await removeData(key: CacheHelperKeys.carData);
  }


 static Future<void> saveUser(User model) async {
    await saveData(key: CacheHelperKeys.user, value: jsonEncode(model.toJson()));
  }


  static Future<CachedUserModel> getUser() async {
    final data = await getData(key: CacheHelperKeys.user);
    final json = jsonDecode(data) as Map<String, dynamic>;
    final User user = User.fromJson(json);
    return CachedUserModel.fromUserModel(user);
  }
}

class CacheHelperKeys {
  static const String token = 'token';
  static const String lang = 'lang';
  static const String user = 'user';
  static const locationEnabled = 'locationEnabled';
  static const carData = 'carData';
}

