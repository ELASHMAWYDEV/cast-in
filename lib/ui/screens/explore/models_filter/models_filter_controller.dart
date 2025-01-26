import 'package:get/get.dart';

class ModelsFilterController extends GetxController {
  List<Map<String, dynamic>> models = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    // Mock data for demonstration
    models = List.generate(
      28,
      (index) => {
        'name': 'belle_benson',
        'age': 23,
        'height': '168cm',
        'city': 'Dubai',
      },
    );
    update();
  }

  void followModel(int index) {
    // Implement follow functionality
  }
}
