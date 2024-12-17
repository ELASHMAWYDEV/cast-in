import 'package:cast_in/screens/login/login_screen.dart';
import 'package:cast_in/services/localization_service.dart';
import 'package:cast_in/utils/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cast In',
      locale: const Locale('en', 'US'),
      supportedLocales: SupportedLocales.locales,
      fallbackLocale: SupportedLocales.en,
      translations: AppTranslations(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
