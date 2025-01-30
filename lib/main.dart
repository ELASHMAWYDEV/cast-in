import 'package:cast_in/services/localization_service.dart';
import 'package:cast_in/services/storage_service.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/app_translations.dart';
import 'package:cast_in/utils/constants.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final supabaseService = await SupabaseService.init();
  await Get.putAsync(() => StorageService.init(), permanent: true);
  Get.put(LocalizationService.init(), permanent: true);
  Get.put(supabaseService, permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      locale: Get.find<LocalizationService>().activeLocale,
      supportedLocales: SupportedLocales.locales,
      fallbackLocale: SupportedLocales.en,
      translations: AppTranslations(),
      getPages: AppRouter.pages,
      initialRoute: AppRouter.initialRoute,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppStyle.primaryColor, secondary: AppStyle.secondaryColor, surface: AppStyle.primaryBgColor),
          useMaterial3: true,
          scaffoldBackgroundColor: AppStyle.primaryBgColor,
          fontFamily: AppStyle.primaryFontFamily),
      themeMode: ThemeMode.light,
    );
  }
}
