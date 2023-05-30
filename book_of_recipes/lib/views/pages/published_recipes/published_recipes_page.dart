import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/recipe_card.dart';
import '../../widgets/search_field.dart';
import '../creating_recipe/creating_recipe_page.dart';
import 'published_recipes_cubit.dart';

class PublishedRecipesPage extends StatelessWidget {
  const PublishedRecipesPage({Key? key}) : super(key: key);

  Widget _body(BuildContext context, PublishedRecipesState state) {
    return Column(
      children: [
        _searchField(context),
        _recipesListView(context, state),
      ],
    );
  }

  Widget _searchField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            SearchField(
              onChanged: context.read<PublishedRecipesCubit>().requestChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipesListView(BuildContext context, PublishedRecipesState state) {
    if (state.recipes.isEmpty) {
      return const Expanded(
        flex: 7,
        child: HintCard(
          text: 'There are no recipes with such a request.',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white30,
          ),
          isMaxWidth: true,
        ),
      );
    }
    return Expanded(
      flex: 7,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.recipes.length,
        itemBuilder: (context, index) => RecipeCard(
          recipe: state.recipes[index],
          isAdmin: true,
          edit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreatingRecipePage(
                  context: context,
                  isCreating: false,
                  editingRecipe: state.recipes[index],
                ),
              ),
            );
            Navigator.pop(context);
          },
          delete: () => context
              .read<PublishedRecipesCubit>()
              .deleteRecipe(state.recipes[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishedRecipesCubit, PublishedRecipesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Published recipes', context: context),
          body: _body(context, state),
          floatingActionButton: CustomFloatingActionButton(
            icon: Icons.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatingRecipePage(context: context),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
