import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cast_in/utils/style.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.name,
      this.labelText,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  final String name;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      builder: (FormFieldState<dynamic> field) => TextField(
        obscureText: obscureText,
        onChanged: field.didChange,
        style: AppStyle.bodyTextStyle3.copyWith(fontWeight: FontWeight.w500),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorText: field.errorText,
            labelText: labelText,
            hintText: hintText,
            labelStyle: AppStyle.headingTextStyle3.copyWith(letterSpacing: 0.5),
            hintStyle: AppStyle.bodyTextStyle3.copyWith(color: Colors.grey),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
}
