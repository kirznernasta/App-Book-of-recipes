part of 'recipe_page_cubit.dart';

class RecipePageState {
  final List<Ingredient> _ingredients;
  final List<Step> _steps;
  final int selectedIndex;
  final int currentStep;

  RecipePageState({
    List<Ingredient> ingredients = const [],
    List<Step> steps = const [],
    this.selectedIndex = 0,
    this.currentStep = 0,
  })  : _steps = steps,
        _ingredients = ingredients;

  List<Ingredient> ingredients(String recipeId) => List<Ingredient>.from(
        _ingredients.where(
          (ingredient) => ingredient.recipeId == recipeId,
        ),
      );

  List<Step> steps(String recipeId) => List<Step>.from(
        _steps.where(
          (step) => step.recipeId == recipeId,
        ),
      );

  RecipePageState copyWith({
    List<Ingredient>? newIngredients,
    List<Step>? newSteps,
    int? newSelectedIndex,
    int? newCurrentStep,
  }) =>
      RecipePageState(
        ingredients: newIngredients ?? _ingredients,
        steps: newSteps ?? _steps,
        selectedIndex: newSelectedIndex ?? selectedIndex,
        currentStep: newCurrentStep ?? currentStep,
      );
}
