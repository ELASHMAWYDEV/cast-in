import 'package:cast_in/ui/screens/auth/login/login_screen.dart';
import 'package:cast_in/ui/screens/auth/profession/profession_screen.dart';
import 'package:cast_in/ui/screens/auth/signup/signup_screen.dart';
import 'package:cast_in/ui/screens/auth/verification/verification_screen.dart';
import 'package:cast_in/ui/screens/main_layout/main_layout_screen.dart';
import 'package:cast_in/ui/screens/post_details/post_details_screen.dart';
import 'package:cast_in/ui/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  // Routes
  static const SPLASH = '/splash';
  static const LOGIN = '/auth/login';
  static const SIGNUP = '/auth/signup';
  static const VERIFICATION = '/auth/verification';
  static const PROFESSION = '/auth/profession';
  static const MAINLAYOUT = '/mainlayout';
  static const POST_DETAILS = '/post_details';

  static const String initialRoute = SPLASH;

  static List<GetPage> get pages => [
        GetPage(
          name: SPLASH,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: LOGIN,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: SIGNUP,
          page: () => SignupScreen(),
        ),
        GetPage(
          name: VERIFICATION,
          page: () => VerificationScreen(),
        ),
        GetPage(
          name: PROFESSION,
          page: () => ProfessionScreen(),
        ),
        GetPage(
          name: MAINLAYOUT,
          page: () => MainLayoutScreen(),
        ),
        GetPage(
          name: POST_DETAILS,
          page: () => PostDetailsScreen(),
        ),
      ];
}
