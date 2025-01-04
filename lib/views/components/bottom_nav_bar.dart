import 'package:ecommerce_provider/provider/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (context, mainScreenProvider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavWidget(
                    iconData: mainScreenProvider.pageIndex == 4
                        ? Ionicons.home
                        : Ionicons.home_outline,
                    onTap: () {
                      mainScreenProvider.pageIndex = 0;
                    },
                    color: mainScreenProvider.pageIndex == 0
                        ? Colors.indigo
                        : Colors.white,
                  ),
                  BottomNavWidget(
                    iconData: mainScreenProvider.pageIndex == 1
                        ? Ionicons.search
                        : Ionicons.search_outline,
                    onTap: () {
                      mainScreenProvider.pageIndex = 1;
                    },
                    color: mainScreenProvider.pageIndex == 1
                        ? Colors.indigo
                        : Colors.white,
                  ),
                  BottomNavWidget(
                    iconData: mainScreenProvider.pageIndex == 2
                        ? Ionicons.heart
                        : Ionicons.heart_circle_outline,
                    onTap: () {
                      mainScreenProvider.pageIndex = 2;
                    },
                    color: mainScreenProvider.pageIndex == 2
                        ? Colors.indigo
                        : Colors.white,
                  ),
                  BottomNavWidget(
                    iconData: mainScreenProvider.pageIndex == 3
                        ? Ionicons.cart
                        : Ionicons.cart_outline,
                    onTap: () {
                      mainScreenProvider.pageIndex = 3;
                    },
                    color: mainScreenProvider.pageIndex == 3
                        ? Colors.indigo
                        : Colors.white,
                  ),
                  BottomNavWidget(
                    iconData: mainScreenProvider.pageIndex == 4
                        ? Ionicons.person
                        : Ionicons.person_outline,
                    onTap: () {
                      mainScreenProvider.pageIndex = 4;
                    },
                    color: mainScreenProvider.pageIndex == 4
                        ? Colors.indigo
                        : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
