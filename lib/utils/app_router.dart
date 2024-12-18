import 'package:cast_in/ui/screens/auth/login/login_screen.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  // Routes
  static const LOGIN = '/login';

  static const String initialRoute = "/login";

  static List<GetPage> get pages => [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
      ];
}
