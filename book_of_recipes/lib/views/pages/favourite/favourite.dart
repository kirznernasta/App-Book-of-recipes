import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/recipe_card.dart';
import 'favourite_cubit.dart';

class Favourite extends StatefulWidget {
  final String userId;
  const Favourite({required this.userId, Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().init(widget.userId);
  }

  Widget _body(FavouriteState state) {
    return Column(
      children: [
        _favouritesListView(state),
      ],
    );
  }

  Widget _favouritesListView(FavouriteState state) {
    if (state.favouriteRecipes.isEmpty) {
      return const Expanded(
        flex: 5,
        child: HintCard(
          isMaxWidth: true,
          text: 'You don\'t have any favourite recipes yet.',
          style: TextStyle(fontSize: 32),
        ),
      );
    }
    return Expanded(
      flex: 5,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.favouriteRecipes.length,
        itemBuilder: (_, index) => RecipeCard(
          recipe: state.favouriteRecipes[index],
          isFavorite: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) => Scaffold(
        appBar: customAppBar(title: 'Favourite recipes', context: context),
        body: _body(state),
      ),
    );
  }
}
