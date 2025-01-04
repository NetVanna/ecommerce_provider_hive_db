import 'package:ecommerce_provider/views/components/category_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../models/sneaker_model.dart';
import '../../services/helpers.dart';
import '../components/app_styles.dart';
import '../components/custom_spacer.dart';
import '../components/latest_shoes.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.17,
                left: 16,
                right: 12,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  LatestShoes(gender: male),
                  LatestShoes(gender: female),
                  LatestShoes(gender: kid),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  var brand=[
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  Future<dynamic> filter() {
    double value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.black38),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text(
                      "Filter",
                      style: appStyle(
                        40,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Gender",
                      style: appStyle(
                        20,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        CategoryBtn(buttonClr: Colors.black, label: "Men"),
                        CategoryBtn(buttonClr: Colors.grey, label: "Women"),
                        CategoryBtn(buttonClr: Colors.grey, label: "Kid"),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appStyle(20, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        CategoryBtn(buttonClr: Colors.black, label: "Shoes"),
                        CategoryBtn(buttonClr: Colors.grey, label: "Apparels"),
                        CategoryBtn(buttonClr: Colors.grey, label: "Accessor"),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                      value: value,
                      min: 0,
                      max: 500,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      divisions: 50,
                      label: value.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (value) {},
                    ),
                    const CustomSpacer(),
                    Text(
                      "Brands",
                      style: appStyle(
                        20,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
