import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/form/input_field.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/auth/forgot_password/forgot_password_controller.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(
          title: 'Forgot Password',
          isBackBtnEnabled: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      InputField(
                        name: 'email',
                        labelText: "Email",
                        hintText: 'myemail@gmail.com',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "Email is required"),
                          FormBuilderValidators.email(errorText: "Email is not valid"),
                        ]),
                      ),
                      SizedBox(height: 20),
                      MainButton(
                        onPressed: controller.sendResetInstructions,
                        title: 'Send Reset Instructions',
                        fullWidth: true,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember your password? ",
                          style: AppStyle.bodyTextStyle2,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            'Login',
                            style: AppStyle.textButtonTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
