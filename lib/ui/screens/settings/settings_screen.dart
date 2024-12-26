import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
        isBackBtnEnabled: true,
      ),
      body: Center(
        child: Text("Settings screen not ready yet"),
      ),
    );
  }
}
