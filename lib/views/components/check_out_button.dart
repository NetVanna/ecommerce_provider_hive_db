import 'package:flutter/material.dart';

import 'app_styles.dart';


class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key, required this.title, this.onTap,
  });
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
        const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(
                  12),
              color: Colors.black),
          height: 50,
          width: MediaQuery.of(context)
              .size
              .width *
              0.9,
          child: Center(
            child: Text(
              title,
              style: appStyle(
                20,
                Colors.white,
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}