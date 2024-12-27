import 'package:cast_in/ui/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:cast_in/utils/style.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cast_in/ui/components/form/drop_down_field.dart';
import 'package:cast_in/ui/screens/explore/filter/filter_controller.dart';

class FilterScreen extends GetView<FilterController> {
  FilterScreen({super.key});

  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      builder: (_) => SizedBox(
        height: Get.height - 220,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Age Range Slider
                _buildLabel('Age', '${controller.ageRange.start.round()}-${controller.ageRange.end.round()}'),
                RangeSlider(
                  values: controller.ageRange,
                  min: 18,
                  max: 50,
                  activeColor: AppStyle.primaryColor,
                  onChanged: controller.updateAgeRange,
                ),
                const SizedBox(height: 20),

                // Height Slider
                _buildLabel('Height', '1-${controller.height.toStringAsFixed(0)}'),
                Slider(
                  value: controller.height,
                  min: 2,
                  max: 8,
                  activeColor: AppStyle.primaryColor,
                  onChanged: controller.updateHeight,
                ),
                const SizedBox(height: 20),

                // Gender Selection
                DropDownField<String>(
                  name: 'gender',
                  labelText: 'Gender',
                  hintText: 'Select Gender',
                  value: controller.selectedGender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: controller.updateGender,
                ),
                const SizedBox(height: 20),

                // Country Selection
                DropDownField<String>(
                  name: 'country',
                  labelText: 'Country',
                  hintText: 'Select Country',
                  value: controller.selectedCountry,
                  items: const ['USA', 'Canada', 'UK', 'Australia'],
                  onChanged: controller.updateCountry,
                ),
                const SizedBox(height: 20),

                // City Selection
                DropDownField<String>(
                  name: 'city',
                  labelText: 'City',
                  hintText: 'Select City',
                  value: controller.selectedCity,
                  items: const ['Mexico', 'New York', 'London', 'Paris'],
                  onChanged: controller.updateCity,
                ),

                const Spacer(),
                // Apply Button
                MainButton(
                  onPressed: controller.applyFilters,
                  title: 'Apply',
                  fullWidth: true,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyle.headingTextStyle2,
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: AppStyle.bodyTextStyle2.copyWith(color: Colors.grey),
          ),
      ],
    );
  }
}
