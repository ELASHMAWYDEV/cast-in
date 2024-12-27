import 'dart:io';

import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/form/drop_down_field.dart';
import 'package:cast_in/ui/screens/auth/components/custom_title_and_suptitle.dart';
import 'package:cast_in/ui/components/profile_photo.dart';
import 'package:cast_in/ui/components/form/input_field.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/auth/signup/signup_controller.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Cast In',
          isBackBtnEnabled: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(spacing: 15, crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomTitleAndSuptitle(title: 'Sign Up', suptitle: 'Create an new account'),
                SizedBox(height: 20),
                Center(
                  child: ProfilePhotoWidget(
                    onPickImage: (File image) {
                      Helpers.appDebugger("Choosed image: $image");
                    },
                  ),
                ),
                FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputField(
                        name: 'full_name',
                        labelText: "Full name",
                        hintText: 'John Smith',
                        validator: FormBuilderValidators.required(
                          errorText: "Full name is required",
                        ),
                      ),
                      SizedBox(height: 15),
                      InputField(
                        name: 'user_name',
                        labelText: "User Name",
                        hintText: '@username',
                        validator: FormBuilderValidators.required(
                          errorText: "Username is required",
                        ),
                      ),
                      SizedBox(height: 15),
                      InputField(
                        name: 'password',
                        labelText: "Password",
                        hintText: '********',
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "Password is required"),
                          FormBuilderValidators.minLength(6, errorText: "Minimum 6 characters"),
                        ]),
                      ),
                      SizedBox(height: 15),
                      InputField(
                        name: 'phone_number',
                        labelText: "Phone No",
                        hintText: '+9999999999',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "Phone number is required"),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.minLength(10, errorText: "Minimum 10 digits"),
                        ]),
                      ),
                      SizedBox(height: 30),
                      DropDownField(
                        name: 'country',
                        labelText: 'Country',
                        hintText: ' your country',
                        items: ['USA', 'UK', 'Canada', 'Dubai', 'India', 'Indonesia'],
                        validator: FormBuilderValidators.required(errorText: 'Country is required'),
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DropDownField(
                        name: 'city',
                        labelText: 'City',
                        hintText: ' your city',
                        items: ['Cairo', 'Alexandria'],
                        validator: FormBuilderValidators.required(errorText: 'City is required'),
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MainButton(
                  onPressed: () async {
                    await controller.signUp();
                  },
                  title: 'Sign Up',
                  fullWidth: true,
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By creating an account you have to agree with our ',
                      style: AppStyle.bodyTextStyle3,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: AppStyle.textButtonTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppStyle.bodyTextStyle2,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text('Login', textAlign: TextAlign.center, style: AppStyle.textButtonTextStyle)),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
