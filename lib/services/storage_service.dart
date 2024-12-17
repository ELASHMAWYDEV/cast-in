import 'package:cast_in/services/localization_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageKeys {
  static const String accessToken = 'ACCESS_TOKEN';
  static const String activeLocale = 'ACTIVE_LOCALE';
}

class StorageService extends GetxService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<StorageService> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  String get accessToken => _prefs.getString(StorageKeys.accessToken) ?? '';

  set accessToken(String value) {
    _prefs.setString(StorageKeys.accessToken, value.toString());
  }

  String get activeLocale =>
      _prefs.getString(StorageKeys.activeLocale) ??
      SupportedLocales.en.languageCode;

  set activeLocale(String value) {
    _prefs.setString(StorageKeys.activeLocale, value.toString());
  }
}
