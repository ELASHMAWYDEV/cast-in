import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cast_in/utils/style.dart';

class DropDownField<T> extends StatelessWidget {
  const DropDownField({
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
    return FormBuilderField<T?>(
      name: name,
      validator: validator,
      builder: (FormFieldState<T?> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null)
              Text(
                labelText!,
                style: AppStyle.headingTextStyle3,
              ),
            InputDecorator(
              decoration: InputDecoration(
                hintText: hintText,
                errorText: field.errorText,
                hintStyle: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.secondaryTextColor),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.5),
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
                child: DropdownButton(
                  value: value,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  hint: Text(
                    hintText ?? '',
                    style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.grey),
                  ),
                  selectedItemBuilder: (_) => items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            item.toString(),
                            style: AppStyle.bodyTextStyle3.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
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
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppStyle.primaryTextColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
