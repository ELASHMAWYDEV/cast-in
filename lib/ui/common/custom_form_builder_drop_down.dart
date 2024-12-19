import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cast_in/utils/style.dart';

class CustomFormBuilderDropdown<T> extends StatelessWidget {
  const CustomFormBuilderDropdown({
    super.key,
    required this.name,
    this.labelText,
    this.hintText,
    required this.items,
    this.validator,
    this.onChanged,
    this.value,
  });

  final String name;
  final String? labelText;
  final String? hintText;
  final List<T> items;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      validator: validator,
      builder: (FormFieldState<T?> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            errorText: field.errorText,
            labelStyle: AppStyle.headingTextStyle3,
            hintStyle: AppStyle.bodyTextStyle3.copyWith(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(vertical: -8),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.5), // Default underline color
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: Text(
                hintText ?? '',
                style: AppStyle.bodyTextStyle3.copyWith(color: Colors.grey),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        item.toString(),
                        style: AppStyle.bodyTextStyle3.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                field.didChange(val);
                if (onChanged != null) onChanged!(val);
              },
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
