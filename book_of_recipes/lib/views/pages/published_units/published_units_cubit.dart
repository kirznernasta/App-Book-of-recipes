import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/unit.dart';
import '../../../repositories/unit_repository.dart';

part 'published_units_state.dart';

class PublishedUnitsCubit extends Cubit<PublishedUnitsState> {
  final UnitRepository _unitRepository;
  late final StreamSubscription<List<Unit>> _unitSubscription;

  PublishedUnitsCubit({required UnitRepository unitRepository})
      : _unitRepository = unitRepository,
        super(PublishedUnitsState()) {
    _initSubscription();
  }

  void _initSubscription() {
    _unitSubscription = _unitRepository.unitStream.listen(
      (units) {
        final sortedUnits = List<Unit>.from(units)
          ..sort(
            (unit1, unit2) => unit1.name.compareTo(
              unit2.name,
            ),
          );
        emit(
          state.copyWith(
            newUnits: sortedUnits,
          ),
        );
      },
    );
  }

  Future<void> deleteUnit(int index) async {
    final productId = state._units[index].id;
    return await _unitRepository.delete(productId);
  }

  void requestChanged(String value) => emit(
        state.copyWith(
          newRequest: value,
        ),
      );
}
