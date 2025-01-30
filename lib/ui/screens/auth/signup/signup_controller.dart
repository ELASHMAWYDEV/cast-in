import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  late final SupabaseService _supabaseService;
  final isLoading = false.obs;
  final selectedCountry = ''.obs;
  final selectedCity = ''.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      _supabaseService = Get.find<SupabaseService>();
      print('SupabaseService initialized successfully');
    } catch (e) {
      print('Error initializing SupabaseService: $e');
    }
  }

  Future signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      _formKey.currentState!.save();
      final formData = _formKey.currentState!.value;

      if (_supabaseService == null) {
        print('SupabaseService is null!');
        throw Exception('SupabaseService not initialized');
      }

      await _supabaseService.signUp(
        fullName: formData['full_name'],
        username: formData['user_name'],
        password: formData['password'],
        phoneNumber: formData['phone_number'],
        country: formData['country'],
        city: formData['city'],
        userType: UserType.model,
      );

      print('Signup successful, navigating to OTP screen');
      Get.toNamed(AppRouter.OTP);
    } catch (e, stackTrace) {
      print('Error during signup: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to sign up: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      print('Signup process completed');
    }
  }
}
