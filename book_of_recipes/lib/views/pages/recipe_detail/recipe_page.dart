import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/recipe.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/ingredient_card.dart';
import '../home/home_cubit.dart';
import 'recipe_page_cubit.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final bool isAdmin;
  final VoidCallback? onHeartPressed;
  final bool isFavorite;

  const RecipePage({
    required this.recipe,
    this.isAdmin = false,
    this.onHeartPressed,
    this.isFavorite = false,
    Key? key,
  }) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final ScrollController _scrollController;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    isFavorite = widget.isFavorite;
  }

  Widget _body(int index, RecipePageState state) {
    if (index == 0) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ),
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: NetworkImage(widget.recipe.photoResult),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            widget.recipe.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      );
    }
    if (index == 1) {
      final ingredients = state.ingredients(widget.recipe.id);
      return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (_, index) => IngredientCard(
          ingredient: ingredients[index],
        ),
      );
    }
    if (index == 2) {
      final steps = state.steps(widget.recipe.id);
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.7,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  onPageChanged: (index, _) =>
                      context.read<RecipePageCubit>().currentStepChanged(index),
                ),
                items: steps.map(
                  (step) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 24,
                        bottom: 24,
                      ),
                      width: 256,
                      height: 256,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: NetworkImage(
                            step.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  steps[state.currentStep].description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      );
    }
    throw Exception('no such index');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, __) {
        return BlocBuilder<RecipePageCubit, RecipePageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: customAppBar(
                title: widget.recipe.name,
                context: context,
                actions: widget.isAdmin
                    ? null
                    : [
                        IconButton(
                          icon: Icon(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: accentColor,
                          ),
                          onPressed: widget.onHeartPressed,
                        )
                      ],
              ),
              body: _body(state.selectedIndex, state),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.selectedIndex,
                onTap: context.read<RecipePageCubit>().selectedIndexChanged,
                selectedItemColor: accentColor,
                items: [
                  const BottomNavigationBarItem(
                    label: 'description',
                    icon: Icon(
                      Icons.description,
                    ),
                  ),
                  const BottomNavigationBarItem(
                    label: 'ingredients',
                    icon: Icon(
                      Icons.fastfood,
                    ),
                  ),
                  const BottomNavigationBarItem(
                    label: 'steps',
                    icon: Icon(
                      Icons.list,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
