import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  Future<void> login() async {
    if (_formKey.currentState!.validate(focusOnInvalid: true)) {
      try {
        _formKey.currentState!.save();
        final values = _formKey.currentState!.value;
        await Get.find<SupabaseService>().signIn(
          email: values['email'],
          password: values['password'],
        );

        // Check if the user is admin
        if (values['email'] == 'admin@gmail.com') {
          Get.offAllNamed(AppRouter.ADMIN_STATISTICS);
        } else {
          Get.offAllNamed(AppRouter.MAINLAYOUT);
        }
      } catch (e) {
        Helpers.appDebugger("Login failed", error: e);
        AppSnackbar.showError(message: "Login failed. Please check your credentials and try again.");
      }
    } else {
      AppSnackbar.showError(message: "Please fill in all required fields correctly.");
    }
  }
}
