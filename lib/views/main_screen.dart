import 'package:ecommerce_provider/provider/main_screen_provider.dart';
import 'package:ecommerce_provider/views/screens/favorite_screen.dart';
import 'package:ecommerce_provider/views/screens/cart_screen.dart';
import 'package:ecommerce_provider/views/screens/home_screen.dart';
import 'package:ecommerce_provider/views/screens/profile_screen.dart';
import 'package:ecommerce_provider/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List pageLists = [
      const HomeScreen(),
      const SearchScreen(),
      const FavoriteScreen(),
      CartScreen(),
      const ProfileScreen(),
    ];
    return Consumer<MainScreenProvider>(
      builder: (context, mainScreenProvider, child) {
        return Scaffold(
          body: pageLists[mainScreenProvider.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}


