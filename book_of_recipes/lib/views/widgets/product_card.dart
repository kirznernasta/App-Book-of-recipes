import 'package:flutter/material.dart';

import '../../constants.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double? imageHeight;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final bool isSelected;

  const ProductCard({
    required this.name,
    required this.imageUrl,
    this.imageHeight,
    this.onLongPress,
    this.onTap,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              24,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: imageHeight ?? 80,
              height: imageHeight ?? 80,
              margin: const EdgeInsets.only(
                right: 24,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? accentColor : Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
