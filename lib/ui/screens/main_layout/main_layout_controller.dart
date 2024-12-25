import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/search/search_screen.dart';
import 'package:get/get.dart';

class MainLayoutController extends GetxController {
  var selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
