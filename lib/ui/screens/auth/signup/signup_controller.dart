import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  final UserType userType = Get.arguments;

  Future signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      _formKey.currentState!.save();
      final formData = _formKey.currentState!.value;

      Helpers.appDebugger(formData);

      final UserModel user = await _supabaseService.signUp(
        fullName: formData['full_name'],
        username: formData['username'],
        email: formData['email'],
        password: formData['password'],
        phoneNumber: formData['phone_number'],
        country: formData['country'],
        city: formData['city'],
        profileImagePath: formData['profile_image']?.path,
        userType: userType,
      );

      Get.toNamed(AppRouter.OTP, arguments: user);
    } catch (e) {
      AppSnackbar.showError(message: e.toString());
    }
  }
}
