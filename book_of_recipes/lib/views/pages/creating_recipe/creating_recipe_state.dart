part of 'creating_recipe_cubit.dart';

class CreatingRecipeState {
  final int stage;
  final String name;
  final String photoResult;
  final String description;
  final int numberOfServing;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final int currentStep;
  final int cookingTimeAmount;
  final String currentTimeChoice;
  final bool isCreating;
  final bool isEditing;
  final bool isSetEditingProperties;
  final String editingRecipeId;

  CreatingRecipeState({
    this.stage = 0,
    this.name = '',
    this.photoResult = '',
    this.description = '',
    this.ingredients = const [],
    this.numberOfServing = 0,
    this.steps = const [],
    this.currentStep = 0,
    this.cookingTimeAmount = 0,
    this.currentTimeChoice = 'h',
    this.isCreating = false,
    this.isEditing = false,
    this.isSetEditingProperties = false,
    this.editingRecipeId = '',
  });

  CreatingRecipeState copyWith({
    int? newStage,
    String? newName,
    String? newPhotoResult,
    String? newDescription,
    int? newNumberOfServing,
    List<Ingredient>? newIngredients,
    List<Step>? newSteps,
    int? newCurrentStep,
    int? newCookingTimeAmount,
    String? newCurrentTimeChoice,
    bool? creating,
    bool? editing,
    bool? setEditingProperties,
    String? newEditingRecipeId,
  }) =>
      CreatingRecipeState(
        stage: newStage ?? stage,
        name: newName ?? name,
        photoResult: newPhotoResult ?? photoResult,
        description: newDescription ?? description,
        numberOfServing: newNumberOfServing ?? numberOfServing,
        ingredients: newIngredients ?? ingredients,
        steps: newSteps ?? steps,
        currentStep: newCurrentStep ?? currentStep,
        cookingTimeAmount: newCookingTimeAmount ?? cookingTimeAmount,
        currentTimeChoice: newCurrentTimeChoice ?? currentTimeChoice,
        isCreating: creating ?? isCreating,
        isEditing: editing ?? isEditing,
        isSetEditingProperties: setEditingProperties ?? isSetEditingProperties,
        editingRecipeId: newEditingRecipeId ?? editingRecipeId,
      );
}
