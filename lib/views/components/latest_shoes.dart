import 'package:ecommerce_provider/views/components/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/sneaker_model.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required this.gender,
  });

  final Future<List<Sneaker>> gender;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneaker>>(
      future: gender,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
              child:
              CircularProgressIndicator()); // Loading indicator.
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  "Error: ${snapshot.error}")); // Display error.
        } else if (!snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
                  "No sneakers available.")); // No data case.
        } else {
          final male =
          snapshot.data!; // Safely unwrap the data.
          return MasonryGridView.builder(
            padding: EdgeInsets.zero,
            itemCount: male.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final shoes =
              male[index]; // Access the current sneaker.
              return StaggerTile(
                imageUrl: shoes.imageUrl[0],
                name: shoes.name,
                price: shoes.price,
              );
            },
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            gridDelegate:
            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          );
        }
      },
    );
  }
}