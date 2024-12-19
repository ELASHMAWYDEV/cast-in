import 'package:get/get.dart';

class ProfessionController extends GetxController {
  String? selectedProfession;

  final List<String> professions = [
    'Company',
    'Foundation',
    'Photographer',
    'Makeup Artist',
    'Director',
    'Fashion',
    'Hairstylist',
    'Co-ordinator',
    'Other',
  ];

  void selectProfession(String profession) {
    selectedProfession = profession;
    update();
  }

  void submitProfession() {
    if (selectedProfession != null) {
      print("Selected Profession: $selectedProfession");
    } else {
      Get.snackbar('Error', 'Please select a profession');
    }
  }
}
