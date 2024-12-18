import 'dart:ui';

import 'package:cast_in/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SupportedLocales {
  static const List<Locale> locales = [Locale('en'), Locale('ar')];

  static Locale en = locales[0];
  static Locale ar = locales[1];
}

class LocalizationService extends GetxService {
  LocalizationService(this._activeLocale);

  final Locale _activeLocale;

  Locale get activeLocale => _activeLocale;

  static LocalizationService init() {
    final String activeLocale = Get.find<StorageService>().activeLocale;
    final Locale locale = SupportedLocales.locales.firstWhere(
      (Locale locale) => locale.languageCode == activeLocale,
      orElse: () => SupportedLocales.en,
    );

    return LocalizationService(locale);
  }

  void changeLocale(languageCode) {
    final Locale newLocale = SupportedLocales.locales.firstWhere(
      (Locale locale) => locale.languageCode == languageCode,
      orElse: () => SupportedLocales.en,
    );

    Get.find<StorageService>().activeLocale = newLocale.languageCode;
    Get.updateLocale(newLocale);
    debugPrint(_activeLocale.languageCode);
  }
}
