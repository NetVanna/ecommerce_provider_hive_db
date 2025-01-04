import 'package:ecommerce_provider/provider/product_details_provider.dart';
import 'package:ecommerce_provider/views/components/product_card.dart';
import 'package:ecommerce_provider/views/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/sneaker_model.dart';
import '../screens/product_by_cart.dart';
import 'app_styles.dart';
import 'new_shoes.dart';

class HomeWidgets extends StatelessWidget {
  const HomeWidgets({
    super.key,
    required this.gender,
    required this.tabIndex,
  });

  final Future<List<Sneaker>> gender;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductDetailProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: FutureBuilder<List<Sneaker>>(
            future: gender, // Assuming `male` is a Future<List<Sneaker>>
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator()); // Loading indicator.
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Error: ${snapshot.error}")); // Display error.
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("No sneakers available.")); // No data case.
              } else {
                final male = snapshot.data!; // Safely unwrap the data.
                return ListView.builder(
                  itemCount: male.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoes = male[index]; // Access the current sneaker.
                    return GestureDetector(
                      onTap: () {
                        productNotifier.shoeSizes = shoes.sizes;
                        print(productNotifier.shoeSizes);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              id: shoes.id,
                              category: shoes.category,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        price: "\$${shoes.price}",
                        name: shoes.name,
                        category: shoes.category,
                        image: shoes.imageUrl.isNotEmpty
                            ? shoes.imageUrl[0]
                            : "https://via.placeholder.com/150",
                        // Fallback image.
                        id: shoes.id,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(
                      24,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCart(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appStyle(
                            22,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: FutureBuilder<List<Sneaker>>(
            future: gender, // Assuming `male` is a Future<List<Sneaker>>
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator()); // Loading indicator.
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Error: ${snapshot.error}")); // Display error.
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("No sneakers available.")); // No data case.
              } else {
                final male = snapshot.data!; // Safely unwrap the data.
                return ListView.builder(
                  itemCount: male.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoes = male[index]; // Access the current sneaker.
                    return NewShoes(image: shoes.imageUrl[0]);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
