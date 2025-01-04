import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_provider/views/components/app_styles.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});

  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.only(top: 12),
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appStyleWithHt(
                      20,
                      Colors.black,
                      FontWeight.w700,
                      1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${widget.price}",
                    style: appStyleWithHt(
                      20,
                      Colors.black,
                      FontWeight.w500,
                      1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
