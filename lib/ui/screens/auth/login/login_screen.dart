import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/ui/components/form/input_field.dart';
import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/auth/login/login_controller.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (_) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text('Cast In',
                            style: AppStyle.headingTextStyle1.copyWith(
                              fontSize: 40,
                            )),
                      ),
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
                                  FormBuilderValidators.required(
                                      errorText: "Email is required"),
                                  FormBuilderValidators.email(
                                      errorText: "Email is not valid"),
                                ]),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InputField(
                                    name: 'password',
                                    labelText: "Password",
                                    hintText: '***********',
                                    obscureText: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: "Password is required")
                                    ]),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Forgot password?',
                                        style: AppStyle.textButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MainButton(
                                onPressed: controller.login,
                                title: 'Login',
                                fullWidth: true,
                              ),
                            ],
                          )),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By creating an account you have to agree with our ',
                                style: AppStyle.bodyTextStyle3,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: AppStyle.textButtonTextStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: AppStyle.bodyTextStyle2,
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRouter.SIGNUP),
                                child: Text('Sign up',
                                    style: AppStyle.textButtonTextStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
