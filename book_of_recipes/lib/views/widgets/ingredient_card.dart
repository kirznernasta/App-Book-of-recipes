import 'package:flutter/material.dart';

import '../../models/ingredient.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;
  final double? imageHeight;
  final VoidCallback? onLongPress;

  const IngredientCard({
    required this.ingredient,
    this.imageHeight,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
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
                    ingredient.productImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.productName,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${ingredient.amount} ${ingredient.unitName}',
                  style: const TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
