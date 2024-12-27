import 'package:cast_in/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    Get.toNamed(AppRouter.OTP);
  }
}
