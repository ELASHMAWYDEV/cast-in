import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/ui/common/app_snackbar.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:get/get.dart';

class ProfessionController extends GetxController {
  final SupabaseService _supabaseService = Get.find<SupabaseService>();
  String? selectedProfession;
  final UserModel userFromSignup = Get.arguments;

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

  void submitProfession() async {
    if (selectedProfession != null) {
      try {
        Helpers.appDebugger("userFromSignup on profession screen $userFromSignup");
        await _supabaseService.updateUserProfile(
            UserModel(id: userFromSignup.id, profession: selectedProfession!, userType: userFromSignup.userType));
        Get.offAllNamed(AppRouter.MAINLAYOUT);
      } catch (e) {
        AppSnackbar.showError(message: e.toString());
      }
    } else {
      AppSnackbar.showError(message: 'Please select a profession');
    }
  }
}
