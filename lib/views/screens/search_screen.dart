import 'package:flutter/material.dart';

import '../components/app_styles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Search Screen",
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
