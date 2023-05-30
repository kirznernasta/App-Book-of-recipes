import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ingredient.dart';
import '../../../models/step.dart';
import '../../../repositories/ingredient_repository.dart';
import '../../../repositories/step_repository.dart';

part 'recipe_page_state.dart';

class RecipePageCubit extends Cubit<RecipePageState> {
  final IngredientRepository _ingredientRepository;
  final StepRepository _stepRepository;

  late final StreamSubscription<List<Ingredient>> _ingredientSubscription;
  late final StreamSubscription<List<Step>> _stepSubscription;

  RecipePageCubit({
    required IngredientRepository ingredientRepository,
    required StepRepository stepRepository,
  })  : _ingredientRepository = ingredientRepository,
        _stepRepository = stepRepository,
        super(RecipePageState()) {
    _init();
  }

  void _init() {
    _ingredientSubscription = _ingredientRepository.ingredientStream.listen(
      (ingredients) {
        emit(
          state.copyWith(
            newIngredients: ingredients,
          ),
        );
      },
    );
    _stepSubscription = _stepRepository.stepStream.listen(
      (steps) {
        emit(
          state.copyWith(
            newSteps: steps,
          ),
        );
      },
    );
  }

  void selectedIndexChanged(int index) => emit(
        state.copyWith(
          newSelectedIndex: index,
        ),
      );

  void currentStepChanged(int index) => emit(
        state.copyWith(
          newCurrentStep: index,
        ),
      );
}
