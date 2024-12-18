import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Signup Screen",
          style: AppStyle.headingTextStyle3,
        ),
      ),
    );
  }
}
