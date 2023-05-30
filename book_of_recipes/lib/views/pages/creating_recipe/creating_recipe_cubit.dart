import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ingredient.dart';
import '../../../models/recipe.dart';
import '../../../models/step.dart';
import '../../../repositories/ingredient_repository.dart';
import '../../../repositories/recipe_repository.dart';
import '../../../repositories/step_repository.dart';
import '../../../services/image_picker.dart';

part 'creating_recipe_state.dart';

class CreatingRecipeCubit extends Cubit<CreatingRecipeState> {
  final RecipeRepository _recipeRepository;
  final IngredientRepository _ingredientRepository;
  final StepRepository _stepRepository;

  CreatingRecipeCubit({
    required RecipeRepository recipeRepository,
    required IngredientRepository ingredientRepository,
    required StepRepository stepRepository,
  })  : _recipeRepository = recipeRepository,
        _ingredientRepository = ingredientRepository,
        _stepRepository = stepRepository,
        super(CreatingRecipeState());

  Future<void> setEditingRecipeInitialProperties(Recipe recipe) async {
    final ingredients =
        await _ingredientRepository.receiveAllFromRecipe(recipe.id);
    final steps = await _stepRepository.receiveAllRecipeSteps(recipe.id);

    final timeAmount =
        recipe.cookingTime.inMinutes / 60 == recipe.cookingTime.inHours
            ? recipe.cookingTime.inHours
            : recipe.cookingTime.inMinutes;

    emit(
      state.copyWith(
        newStage: 0,
        newName: recipe.name,
        newIngredients: ingredients,
        newSteps: steps,
        newDescription: recipe.description,
        newPhotoResult: recipe.photoResult,
        newNumberOfServing: recipe.numberOfServing,
        newCurrentTimeChoice:
            recipe.cookingTime.inMinutes / 60 == recipe.cookingTime.inHours
                ? 'h'
                : 'm',
        newCookingTimeAmount: timeAmount,
        editing: true,
        setEditingProperties: true,
        newEditingRecipeId: recipe.id,
      ),
    );
  }

  void nameChanged(String? value) => emit(
        state.copyWith(
          newName: value,
        ),
      );

  void descriptionChanged(String? value) => emit(
        state.copyWith(
          newDescription: value,
        ),
      );

  void numberOfServingChanged(String value) => emit(
        state.copyWith(
          newNumberOfServing: int.parse(value),
        ),
      );

  void cookingTimeAmountChanged(String value) => emit(
        state.copyWith(
          newCookingTimeAmount: int.parse(value),
        ),
      );

  void currentTimeChoiceChanged(String value) => emit(
        state.copyWith(
          newCurrentTimeChoice: value,
        ),
      );

  Future<void> pickImage(bool isFromGallery) async {
    final pickedFile =
        await ImagePicker.pickImage(isFromGallery: isFromGallery);
    if (pickedFile != null) {
      emit(
        state.copyWith(
          newPhotoResult: pickedFile.path,
        ),
      );
    }
  }

  void nextStage() => emit(
        state.copyWith(
          newStage: state.stage + 1,
        ),
      );

  void previousStage() => emit(
        state.copyWith(
          newStage: state.stage - 1,
        ),
      );

  void addIngredient(Ingredient ingredient) => emit(
        state.copyWith(
          newIngredients: List.of(state.ingredients)
            ..add(
              ingredient,
            ),
        ),
      );

  void removeIngredient(Ingredient deletedIngredient) => emit(
        state.copyWith(
          newIngredients: List.of(state.ingredients)
            ..removeWhere((ingredient) =>
                ingredient.productName == deletedIngredient.productName),
        ),
      );

  void updateIngredient(Ingredient editedIngredient) => emit(
        state.copyWith(
          newIngredients: List.of(state.ingredients)
            ..removeWhere((ingredient) =>
                ingredient.productName == editedIngredient.productName)
            ..add(editedIngredient),
        ),
      );

  void addStep(Step nextStep) => emit(
        state.copyWith(
          newSteps: List.of(state.steps)
            ..add(
              nextStep.copyWith(newNumber: state.steps.length + 1),
            ),
        ),
      );

  void changeCurrentStep(int index) => emit(
        state.copyWith(
          newCurrentStep: index,
        ),
      );

  Future<void> createRecipe() async {
    emit(
      state.copyWith(
        creating: true,
      ),
    );
    if (state.isEditing) {
      final recipe = Recipe(
        id: state.editingRecipeId,
        name: state.name,
        description: state.description,
        cookingTime: state.currentTimeChoice == 'h'
            ? Duration(hours: state.cookingTimeAmount)
            : Duration(minutes: state.cookingTimeAmount),
        date: DateTime.now(),
        photoResult: state.photoResult,
        numberOfServing: state.numberOfServing,
        author: 'admin',
        isPublished: true,
        isRequested: false,
      );
      await _recipeRepository.update(recipe);

      for (final ingredient in state.ingredients) {
        if (ingredient.id == '') {
          await _ingredientRepository.add(
            ingredient.copyWith(
              newRecipeId: recipe.id,
            ),
          );
        } else {
          await _ingredientRepository.update(ingredient);
        }
      }
      for (final step in state.steps) {
        if (step.id == '') {
          await _stepRepository.add(
            step.copyWith(
              newRecipeId: recipe.id,
            ),
          );
        } else {
          await _stepRepository.update(step);
        }
      }
      emit(CreatingRecipeState());
    } else {
      final recipe = Recipe(
        id: '',
        name: state.name,
        description: state.description,
        cookingTime: state.currentTimeChoice == 'h'
            ? Duration(hours: state.cookingTimeAmount)
            : Duration(minutes: state.cookingTimeAmount),
        date: DateTime.now(),
        photoResult: state.photoResult,
        numberOfServing: state.numberOfServing,
        author: 'admin',
        isPublished: true,
        isRequested: false,
      );
      final recipeId = await _recipeRepository.add(recipe);
      for (final ingredient in state.ingredients) {
        await _ingredientRepository.add(
          ingredient.copyWith(
            newRecipeId: recipeId,
          ),
        );
      }
      for (final step in state.steps) {
        await _stepRepository.add(
          step.copyWith(
            newRecipeId: recipeId,
          ),
        );
      }
      emit(CreatingRecipeState());
    }
  }

  void reset() => emit(
        state.copyWith(
          newStage: 0,
          newName: '',
          newPhotoResult: '',
          newDescription: '',
          newNumberOfServing: 0,
          newIngredients: const [],
          newSteps: const [],
          newCurrentStep: 0,
          newCookingTimeAmount: 0,
          newCurrentTimeChoice: 'h',
          creating: false,
          editing: false,
          setEditingProperties: false,
          newEditingRecipeId: '',
        ),
      );
}
