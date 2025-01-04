import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_provider/provider/product_details_provider.dart';
import 'package:ecommerce_provider/services/helpers.dart';
import 'package:ecommerce_provider/views/components/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../models/sneaker_model.dart';
import '../components/check_out_button.dart';
import 'favorite_screen.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController pageController = PageController();
  late Future<Sneaker> sneaker;
  final cartBox = Hive.box('cart_box');
  final favBox = Hive.box('fav_box');

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await favBox.add(addFav);
    getFavorites();
    setState(() {});
  }

  void getFavorites() {
    final favData = favBox.keys
        .map((key) {
      final item = favBox.get(key);
      if (item is Map<String, dynamic> && item.containsKey('id')) {
        return {
          "key": key,
          "id": item['id'], // Ensure 'id' exists in the stored data
        };
      }
      return null; // Handle cases where 'id' is missing or invalid
    })
        .where((element) => element != null)
        .toList();

    favor = favData.cast<Map<String, dynamic>>(); // Ensure it's a list of maps
    ids = favor.map((item) => item['id'] as String).toList(); // Cast to String
    setState(() {});
  }
  void getShoe() {
    if (widget.category == "Men's Running") {
      sneaker = Helper().getMenSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      sneaker = Helper().getWomenSneakersById(widget.id);
    } else {
      sneaker = Helper().getKidSneakersById(widget.id);
    }
  }
  Future<void> _createCart(Map<String,dynamic> newCart)async{
    await cartBox.add(newCart);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoe();
    getFavorites();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Sneaker>(
        future: sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator.
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final sneaker = snapshot.data!;
            return Consumer<ProductDetailProvider>(
              builder: (context, productDetailProvider, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productDetailProvider.shoeSizes.clear();
                              },
                              child: const Icon(AntDesign.close),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Ionicons.ellipsis_horizontal),
                            ),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (value) {
                                  productDetailProvider.activePage = value;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (ids.contains(widget.id)) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const FavoriteScreen(),
                                                ),
                                              );
                                            } else {
                                              _createFav({
                                                "id": sneaker.id,
                                                "name": sneaker.name,
                                                "category": sneaker.category,
                                                "price": sneaker.price,
                                                "imageUrl": sneaker.imageUrl[0],
                                              });
                                            }
                                          },
                                          child: ids.contains(widget.id)
                                              ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                              : const Icon(AntDesign.hearto),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    productDetailProvider
                                                                .activePage ==
                                                            index
                                                        ? Colors.black
                                                        : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.name,
                                          style: appStyle(
                                            40,
                                            Colors.black,
                                            FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: appStyle(
                                                20,
                                                Colors.grey,
                                                FontWeight.w500,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: appStyle(
                                                26,
                                                Colors.black,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appStyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Selected sizes",
                                                  style: appStyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  "View sizes guide",
                                                  style: appStyle(
                                                    20,
                                                    Colors.grey,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                itemCount: productDetailProvider
                                                    .shoeSizes.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  final sizes =
                                                      productDetailProvider
                                                          .shoeSizes[index];
                                                  return InkWell(
                                                    onTap: () {
                                                      productDetailProvider
                                                          .toggleCheck(index);
                                                      if(productDetailProvider.sizes.contains(sizes['size'])){
                                                        productDetailProvider.sizes.remove(sizes['size']);
                                                      }else{
                                                        productDetailProvider.sizes.add(sizes['size']);
                                                      }
                                                      // print(productDetailProvider.sizes);
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    // Ensures circular ripple effect
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      alignment:
                                                          Alignment.center,
                                                      // Keeps content in the center
                                                      decoration: BoxDecoration(
                                                        color:
                                                            sizes['isSelected']
                                                                ? Colors.black
                                                                : Colors.white,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      // Padding for label
                                                      child: Text(
                                                        sizes['size'],
                                                        style: appStyle(
                                                          16,
                                                          sizes['isSelected']
                                                              ? Colors.white
                                                              : Colors.black,
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            sneaker.title,
                                            style: appStyle(
                                              26,
                                              Colors.black,
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          sneaker.description,
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: appStyle(
                                            20,
                                            Colors.grey,
                                            FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: CheckOutButton(
                                              title: 'Add to Cart',
                                              onTap: () async{
                                                _createCart({
                                                  "id":sneaker.id,
                                                  "name":sneaker.name,
                                                  "category":sneaker.category,
                                                  "sizes":productDetailProvider.sizes,
                                                  "imageUrl":sneaker.imageUrl[0],
                                                  "price":sneaker.price,
                                                  "qty":1
                                                });
                                                productDetailProvider.sizes.clear();
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
