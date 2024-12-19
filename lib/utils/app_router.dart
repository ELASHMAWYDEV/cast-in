import 'package:cast_in/ui/screens/auth/login/login_screen.dart';
import 'package:cast_in/ui/screens/auth/profession/profession_screen.dart';
import 'package:cast_in/ui/screens/auth/signup/signup_screen.dart';
import 'package:cast_in/ui/screens/auth/verification/verification_screen.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  // Routes
  static const LOGIN = '/auth/login';
  static const SIGNUP = '/auth/signup';
  static const verification = '/auth/verification';
  static const profession = '/auth/profession';

  static const String initialRoute = LOGIN;

  static List<GetPage> get pages => [
        GetPage(
          name: LOGIN,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: SIGNUP,
          page: () => SignupScreen(),
        ),
        GetPage(
          name: verification,
          page: () => VerificationScreen(),
        ),
        GetPage(
          name: profession,
          page: () => ProfessionScreen(),
        ),
      ];
}
