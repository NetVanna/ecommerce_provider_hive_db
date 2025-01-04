import 'package:flutter/material.dart';

import '../components/app_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Favorite Screen",
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
