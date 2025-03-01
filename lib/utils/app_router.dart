import 'package:cast_in/ui/screens/admin/reports/reports_screen.dart';
import 'package:cast_in/ui/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:cast_in/ui/screens/auth/login/login_screen.dart';
import 'package:cast_in/ui/screens/auth/profession/profession_screen.dart';
import 'package:cast_in/ui/screens/auth/signup/signup_screen.dart';
import 'package:cast_in/ui/screens/auth/verification/otp_screen.dart';
import 'package:cast_in/ui/screens/explore/view_all/explore_view_all_screen.dart';
import 'package:cast_in/ui/screens/main/main_screen.dart';
import 'package:cast_in/ui/screens/notifications/notifications_screen.dart';
import 'package:cast_in/ui/screens/post_details/post_details_screen.dart';
import 'package:cast_in/ui/screens/profile/view_profile/view_profile_screen.dart';
import 'package:cast_in/ui/screens/splash/splash_screen.dart';
import 'package:cast_in/ui/screens/messages/chat/chat_screen.dart';
import 'package:get/get.dart';
import 'package:cast_in/ui/screens/admin/statistics/statistics_screen.dart';
import 'package:cast_in/ui/screens/admin/user_management/user_management_screen.dart';

abstract class AppRouter {
  // Routes
  static const SPLASH = '/splash';
  static const LOGIN = '/auth/login';
  static const FORGOT_PASSWORD = '/auth/forgot-password';
  static const SIGNUP = '/auth/signup';
  static const OTP = '/auth/otp';
  static const PROFESSION = '/auth/profession';
  static const MAINLAYOUT = '/main';
  static const POST_DETAILS = '/main/post-details';
  static const NOTIFICATIONS = '/main/notifications';
  static const CHAT = '/main/messages/chat';
  static const VIEW_PROFILE = '/main/view-profile';
  static const EXPLORE_VIEW_ALL = '/main/explore/view-all';
  static const ADMIN_STATISTICS = '/admin/statistics';
  static const ADMIN_USER_MANAGEMENT = '/admin/user-management';
  static const ADMIN_REPORTS = '/admin/reports';

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
          name: FORGOT_PASSWORD,
          page: () => ForgotPasswordScreen(),
        ),
        GetPage(
          name: OTP,
          page: () => OtpScreen(),
        ),
        GetPage(
          name: PROFESSION,
          page: () => ProfessionScreen(),
        ),
        GetPage(name: MAINLAYOUT, page: () => MainScreen()),
        GetPage(
          name: POST_DETAILS,
          page: () => PostDetailsScreen(),
        ),
        GetPage(
          name: CHAT,
          page: () => ChatScreen(),
        ),
        GetPage(
          name: NOTIFICATIONS,
          page: () => NotificationsScreen(),
        ),
        GetPage(
          name: VIEW_PROFILE,
          page: () => ViewProfileScreen(),
        ),
        GetPage(
          name: EXPLORE_VIEW_ALL,
          page: () => ExploreViewAllScreen(
            showPhotoPosts: Get.arguments['showPhotoPosts'] ?? false,
          ),
        ),
        GetPage(
          name: ADMIN_STATISTICS,
          page: () => StatisticsScreen(),
        ),
        GetPage(
          name: ADMIN_USER_MANAGEMENT,
          page: () => UserManagementScreen(),
        ),
        GetPage(
          name: ADMIN_REPORTS,
          page: () => ReportsScreen(),
        ),
      ];
}
