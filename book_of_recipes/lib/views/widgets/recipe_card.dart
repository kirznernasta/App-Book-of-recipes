import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/recipe.dart';
import '../pages/recipe_detail/recipe_page.dart';
import 'published_item_menu.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isAdmin;
  final VoidCallback? edit;
  final VoidCallback? delete;
  final bool isFavorite;
  final VoidCallback? onHeartPressed;

  const RecipeCard({
    required this.recipe,
    this.isAdmin = false,
    this.edit,
    this.delete,
    this.isFavorite = false,
    this.onHeartPressed,
    Key? key,
  }) : super(key: key);

  void _showMenu({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PublishedItemMenuBuilder(
        onEditTap: edit,
        onDeleteTap: () => _onDeleteTap(context),
      ),
    );
  }

  void _onDeleteTap(BuildContext context) {
    Navigator.pop(context);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Delete this recipe?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          GestureDetector(
            onTap: delete,
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipePage(
              recipe: recipe,
              isAdmin: isAdmin,
              isFavorite: isFavorite,
              onHeartPressed: onHeartPressed,
            ),
          ),
        );
      },
      onLongPress: isAdmin ? () => _showMenu(context: context) : null,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.photoResult),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  32,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  32,
                ),
                bottomRight: Radius.circular(
                  32,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer),
                        Text(
                            '${recipe.cookingTime.inHours != 0 ? '${recipe.cookingTime.inHours} h' : ''} '
                            '${recipe.cookingTime.inMinutes - 60 * recipe.cookingTime.inHours} min'),
                      ],
                    ),
                    if (recipe.cookingTime.inHours < 1)
                      const Text(
                        'Easy',
                        style: TextStyle(fontSize: 24, color: Colors.green),
                      ),
                    if (recipe.cookingTime.inHours >= 1 &&
                        recipe.cookingTime.inHours < 3)
                      const Text(
                        'Medium',
                        style: TextStyle(fontSize: 24, color: Colors.orange),
                      ),
                    if (recipe.cookingTime.inHours >= 3)
                      const Text(
                        'Hard',
                        style: TextStyle(fontSize: 24, color: Colors.red),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.restaurant_outlined),
                        Text(' ${recipe.numberOfServing}')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
