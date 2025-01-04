import 'package:flutter/material.dart';

import '../components/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Profile Screen",
          style: appStyle(
            40,
            Colors.indigo,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
