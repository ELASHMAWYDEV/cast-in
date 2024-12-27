import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;


  void login() {
    if (_formKey.currentState!.validate(focusOnInvalid: true)) {
      Helpers.appDebugger("Valid");
      Get.toNamed(AppRouter.MAINLAYOUT);
      return _formKey.currentState!.save();
    }
    Helpers.appDebugger("Invalid");
  }
}
