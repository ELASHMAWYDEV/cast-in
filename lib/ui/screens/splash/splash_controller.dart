import 'dart:async';

import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final SupabaseService _supabaseService = Get.find<SupabaseService>();

  @override
  void onInit() {
    super.onInit();
    checkAuthAndNavigate();
  }

  Future<void> checkAuthAndNavigate() async {
    try {
      // Wait for 2 seconds to show splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Check if there's a persisted session
      final hasSession = _supabaseService.client.auth.currentSession;
      Helpers.appDebugger('Current session: ${hasSession?.user.email}');

      if (hasSession != null) {
        // User has a valid session
        if (hasSession.user.email == 'admin@gmail.com') {
          Get.offAllNamed(AppRouter.ADMIN_STATISTICS);
        } else {
          Get.offAllNamed(AppRouter.MAINLAYOUT);
        }
      } else {
        // No valid session, go to login
        Get.offAllNamed(AppRouter.LOGIN);
      }
    } catch (e) {
      Helpers.appDebugger('Error checking auth state', error: e);
      // In case of any error, safely redirect to login
      Get.offAllNamed(AppRouter.LOGIN);
    }
  }
}
