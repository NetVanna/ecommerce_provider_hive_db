import 'package:ecommerce_provider/views/components/app_styles.dart';
import 'package:ecommerce_provider/views/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants/constant.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.name,
      required this.category,
      required this.image,
      required this.id});

  final String price;
  final String name;
  final String category;
  final String image;
  final String id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;
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

  @override
  void initState() {
    super.initState();
    getFavorites(); // Ensure favorites are loaded on init
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
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
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: ids.contains(widget.id)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(AntDesign.hearto),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHt(
                        36,
                        Colors.black,
                        FontWeight.bold,
                        1.1,
                      ),
                    ),
                    Text(
                      widget.category,
                      style: appStyleWithHt(
                        18,
                        Colors.grey,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appStyle(
                        25,
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
                            Colors.grey,
                            FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ChoiceChip(
                          onSelected: (value) {
                            setState(() {
                              selected = value;
                            });
                          },
                          label: const Text(""),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          shape: const CircleBorder(),
                          selectedColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
