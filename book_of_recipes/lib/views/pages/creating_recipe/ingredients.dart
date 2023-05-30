import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/ingredient.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/ingredient_card.dart';
import '../../widgets/published_item_menu.dart';
import '../ingredient_managing/ingredient_managing.dart';
import 'creating_recipe_cubit.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  void _showMenu({
    required BuildContext context,
    required Ingredient ingredient,
    required CreatingRecipeState state,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PublishedItemMenuBuilder(
        onEditTap: () => _onEditTap(
          context: context,
          editingIngredient: ingredient,
          state: state,
        ),
        onDeleteTap: () => _onDeleteTap(
          context: context,
          ingredient: ingredient,
          state: state,
        ),
      ),
    );
  }

  void _onEditTap({
    required BuildContext context,
    required Ingredient editingIngredient,
    required CreatingRecipeState state,
  }) async {
    // ignore: omit_local_variable_types
    Ingredient? editedIngredient = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IngredientManagingPage(
          existingProductNames: state.ingredients
              .map((ingredient) => ingredient.productName)
              .toList(),
          isCreating: false,
          editingIngredient: editingIngredient,
        ),
      ),
    );

    if (editedIngredient != null) {
      context.read<CreatingRecipeCubit>().updateIngredient(editedIngredient);
    }
    Navigator.pop(context);
  }

  void _onDeleteTap({
    required BuildContext context,
    required Ingredient ingredient,
    required CreatingRecipeState state,
  }) {
    context.read<CreatingRecipeCubit>().removeIngredient(ingredient);
    Navigator.pop(context);
  }

  Widget _body(CreatingRecipeState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingredients:',
            ),
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () async {
                // ignore: omit_local_variable_types
                Ingredient? ingredient = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IngredientManagingPage(
                      existingProductNames: state.ingredients
                          .map(
                            (ingredient) => ingredient.productName,
                          )
                          .toList(),
                    ),
                  ),
                );
                if (ingredient != null) {
                  context.read<CreatingRecipeCubit>().addIngredient(ingredient);
                }
              },
              child: Container(
                height: 24,
                width: 128,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(48),
                ),
                child: const Center(
                  child: Text(
                    'add ingredient',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (state.ingredients.isEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: const HintCard(
              text: 'Empty ingredients! \nAdd at least one to create a recipe!',
            ),
          ),
        if (state.ingredients.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => IngredientCard(
                ingredient: state.ingredients[index],
                onLongPress: () => _showMenu(
                  context: context,
                  ingredient: state.ingredients[index],
                  state: state,
                ),
              ),
              itemCount: state.ingredients.length,
            ),
          ), /*
        const SizedBox(
          height: 240,
        ),*/
      ],
    );
  }

  Widget _buttons(CreatingRecipeState state) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          left: 32.0,
          child: _backButton(),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: _forwardButton(state),
        ),
      ],
    );
  }

  Widget _backButton() {
    return FloatingActionButton(
      elevation: 16,
      onPressed: () {
        context.read<CreatingRecipeCubit>().previousStage();
      },
      backgroundColor: accentColor,
      child: const Center(
        child: Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    );
  }

  Widget _forwardButton(CreatingRecipeState state) {
    return FloatingActionButton(
      elevation: 16,
      onPressed: () {
        if (state.ingredients.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Recipe must have at least one ingredient!',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.grey[800],
            ),
          );
        } else {
          context.read<CreatingRecipeCubit>().nextStage();
        }
      },
      backgroundColor: accentColor,
      child: const Icon(
        Icons.arrow_forward,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatingRecipeCubit, CreatingRecipeState>(
      builder: (_, state) {
        return Scaffold(
          body: _body(state),
          floatingActionButton: _buttons(state),
        );
      },
    );
  }
}
