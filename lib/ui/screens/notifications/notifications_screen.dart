import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications", isBackBtnEnabled: true),
      body: Center(
        child: Text("Notifications screen not ready yet"),
      ),
    );
  }
}
