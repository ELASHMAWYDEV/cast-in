import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  RxString timer = '0:09'.obs;
  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  final UserModel userFromSignup = Get.arguments;

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }

  void submitCode() async {
    final code = pinController.text.trim();
    if (code.length != 6) {
      AppSnackbar.showError(message: 'Please enter a valid 6-digit code');
      return;
    }

    try {
      Helpers.appDebugger("userFromSignup $userFromSignup");
      await _supabaseService.verifyOtp(email: userFromSignup.email!, token: code, type: "signup");

      if (userFromSignup.userType == UserType.client) {
        Get.offAllNamed(AppRouter.PROFESSION, arguments: userFromSignup);
      } else {
        Get.offAllNamed(AppRouter.MAINLAYOUT);
      }
    } catch (e) {
      AppSnackbar.showError(message: e.toString());
    }
  }

  void resendCode() {
    timer.value = '0:09';
    AppSnackbar.showSuccess(message: 'Verification code sent again');
  }
}
