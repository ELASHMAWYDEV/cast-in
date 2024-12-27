import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:cast_in/services/supabase_service.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final _supabaseService = Get.find<SupabaseService>();

  Future<void> sendResetInstructions() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      final email = formKey.currentState!.value['email'] as String;
      await _supabaseService.resetPassword(email);
      Get.back();
      AppSnackbar.showSuccess(message: 'Reset instructions sent to your email');
    } catch (e) {
      Helpers.appDebugger('Error sending reset instructions', error: e);
      AppSnackbar.showError(message: 'Failed to send reset instructions');
    }
  }
}
