import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../../models/unit.dart';
import '../../../repositories/unit_repository.dart';

part 'ingredient_managing_state.dart';

class IngredientManagingCubit extends Cubit<IngredientManagingState> {
  final UnitRepository _unitRepository;
  late final StreamSubscription<List<Unit>> _unitSubscription;
  IngredientManagingCubit({required UnitRepository unitRepository})
      : _unitRepository = unitRepository,
        super(IngredientManagingState()) {
    _initSubscription();
  }

  void _initSubscription() {
    _unitSubscription = _unitRepository.unitStream.listen(
      (units) {
        emit(
          state.copyWith(
            newUnits: units,
          ),
        );
      },
    );
  }

  void setIngredientProperties({
    required String productName,
    required String productImage,
    required double amount,
    required List<String> existingProductNames,
    required String unitName,
  }) =>
      emit(
        state.copyWith(
          newProductName: productName,
          newProductImage: productImage,
          newAmount: amount,
          newExistingProductNames: existingProductNames,
          newSelectedUnit: unitName,
        ),
      );

  void setExistingProductNames(List<String> productNames) => emit(
        state.copyWith(
          newExistingProductNames: productNames,
        ),
      );

  void setProductProperties(Product product) => emit(
        state.copyWith(
          newProductName: product.name,
          newProductImage: product.image,
        ),
      );

  void amountChanged(String value) => emit(
        state.copyWith(
          newAmount: value != '' ? double.parse(value) : 0,
        ),
      );

  void selectedUnitChanged(String? value) => emit(
        state.copyWith(
          newSelectedUnit: value ?? 'g',
        ),
      );

  void reset() => emit(IngredientManagingState(units: state.units));
}
