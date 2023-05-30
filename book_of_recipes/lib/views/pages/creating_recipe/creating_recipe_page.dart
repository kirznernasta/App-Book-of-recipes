import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/recipe.dart';
import '../../widgets/custom_app_bar.dart';
import 'creating_recipe_cubit.dart';
import 'ingredients.dart';
import 'main_characteristics.dart';
import 'steps.dart';

class CreatingRecipePage extends StatefulWidget {
  final bool isAdmin;
  final bool isCreating;
  final Recipe? editingRecipe;

  CreatingRecipePage({
    required BuildContext context,
    this.isAdmin = false,
    this.isCreating = true,
    this.editingRecipe,
    Key? key,
  }) : super(key: key) {
    if (!isCreating) {
      context
          .read<CreatingRecipeCubit>()
          .setEditingRecipeInitialProperties(editingRecipe!);
    }
  }

  @override
  State<CreatingRecipePage> createState() => _CreatingRecipePageState();
}

class _CreatingRecipePageState extends State<CreatingRecipePage> {
  Widget _body(CreatingRecipeState state) {
    if (state.stage == 0) {
      return const MainCharacteristics();
    }
    if (state.stage == 1) {
      return const Ingredients();
    }
    if (state.stage == 2) {
      return const Steps();
    }
    throw Exception('Unexpected stage of creating recipe!');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatingRecipeCubit, CreatingRecipeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Recipe creation', context: context),
          body: WillPopScope(
            onWillPop: () {
              if (!widget.isCreating) {
                context.read<CreatingRecipeCubit>().reset();
              }
              return Future.value(true);
            },
            child: _body(state),
          ),
        );
      },
    );
  }
}
