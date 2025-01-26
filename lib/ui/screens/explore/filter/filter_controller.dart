import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FilterController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  // Range values for age slider
  RangeValues ageRange = const RangeValues(18, 22);

  // Value for height slider
  double height = 5;

  // Selected values for dropdowns
  String? selectedGender;
  String? selectedCountry;
  String? selectedCity;

  // Update methods for each field
  void updateAgeRange(RangeValues values) {
    ageRange = values;
    update();
  }

  void updateHeight(double value) {
    height = value;
    update();
  }

  void updateGender(String? value) {
    if (value != null) {
      selectedGender = value;
      update();
    }
  }

  void updateCountry(String? value) {
    if (value != null) {
      selectedCountry = value;
      update();
    }
  }

  void updateCity(String? value) {
    if (value != null) {
      selectedCity = value;
      update();
    }
  }

  void applyFilters() {
    return Get.find<MainController>().goToScreen(MainRouter.MODELS_FILTER);

    // if (formKey.currentState?.saveAndValidate() ?? false) {
    //   final filterData = {
    //     'age_range': {
    //       'min': ageRange.start.round(),
    //       'max': ageRange.end.round(),
    //     },
    //     'height': height.round(),
    //     'gender': selectedGender,
    //     'country': selectedCountry,
    //     'city': selectedCity,
    //   };

    //   // Go back to Explore screen
    // }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with any saved filter values if needed
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
