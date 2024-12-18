import 'package:cast_in/ui/screens/auth/login/login_screen.dart';
import 'package:cast_in/ui/screens/auth/signup/signup_screen.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  // Routes
  static const LOGIN = '/auth/login';
  static const SIGNUP = '/auth/signup';

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
      ];
}
