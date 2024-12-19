import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  @override
  void onInit() {
    super.onInit();
  }

  void signUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
