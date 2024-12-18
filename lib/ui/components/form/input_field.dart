import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cast_in/utils/style.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.name,
    this.labelText,
    this.hintText,
    this.validator,
    this.obscureText = false,
  });

  final String name;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      builder: (FormFieldState<dynamic> field) => TextField(
        obscureText: obscureText,
        onChanged: field.didChange,
        decoration: InputDecoration(
            errorText: field.errorText,
            labelText: labelText,
            hintText: hintText,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: AppStyle.headingTextStyle3,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
}
