import 'package:ecommerce_provider/services/helpers.dart';
import 'package:ecommerce_provider/views/components/app_styles.dart';
import 'package:flutter/material.dart';

import '../../models/sneaker_model.dart';
import '../components/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  late Future<List<Sneaker>> male;
  late Future<List<Sneaker>> female;
  late Future<List<Sneaker>> kid;

  void getMale() {
    male = Helper().getMenSneakers();
  }
  void getFemale() {
    female = Helper().getWomenSneakers();
  }
  void getKids() {
    kid = Helper().getKidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20),
            width: mediaQuery.width,
            height: mediaQuery.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/top_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Athletics Shoes",
                  style: appStyleWithHt(
                    30,
                    Colors.white,
                    FontWeight.bold,
                    1.5,
                  ),
                ),
                Text(
                  "Collection",
                  style: appStyleWithHt(
                    30,
                    Colors.white,
                    FontWeight.bold,
                    1.5,
                  ),
                ),
                TabBar(
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                  unselectedLabelColor: Colors.grey.withOpacity(0.3),
                  tabs: const [
                    Tab(
                      text: "Men Shoes",
                    ),
                    Tab(
                      text: "Women Shoes",
                    ),
                    Tab(
                      text: "Kid Shoes",
                    ),
                  ],
                ),
              ],
            ),
          ),
          // TabBar

          // TabBarView filling the remaining space
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.265,
              left: 15,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeWidgets(gender: male, tabIndex: 0,),
                HomeWidgets(gender: female, tabIndex: 1,),
                HomeWidgets(gender: kid, tabIndex: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
