import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }
}
