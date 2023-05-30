import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/unit.dart';
import '../../../repositories/unit_repository.dart';

part 'unit_managing_state.dart';

class UnitManagingCubit extends Cubit<UnitManagingState> {
  final UnitRepository _unitRepository;

  UnitManagingCubit({
    required UnitRepository unitRepository,
  })  : _unitRepository = unitRepository,
        super(UnitManagingState());

  void nameChanged(String? value) => emit(
        state.copyWith(
          newName: value,
        ),
      );

  void onApplyButton({required bool isCreating, Unit? unit}) {
    assert(isCreating || !isCreating && unit != null,
        'if editing mode, unit has to be not null');

    if (isCreating) {
      tryCreate();
    } else {
      edit(unit!);
    }
  }

  Future<void> edit(Unit unit) async {
    emit(
      state.copyWith(
        tryingCreate: true,
      ),
    );
    await _unitRepository.update(
      unit.copyWith(
        newName: state.name == '' ? unit.name : state.name,
      ),
    );
    emit(
      state.copyWith(
        createdSuccessfully: true,
      ),
    );
  }

  Future<void> tryCreate() async {
    emit(
      state.copyWith(
        newErrorMessage: '',
        tryingCreate: true,
      ),
    );
    final products = await _unitRepository.receiveAll();
    if (products
        .map((unit) => unit.name.toLowerCase())
        .contains(state.name.toLowerCase())) {
      emit(
        state.copyWith(
          tryingCreate: false,
          newErrorMessage: 'Unit is already exists.',
        ),
      );
    } else {
      final unit = Unit(
        id: '',
        name: state.name,
      );
      await _unitRepository.add(unit);
      emit(
        state.copyWith(
          newErrorMessage: '',
          tryingCreate: false,
          createdSuccessfully: true,
        ),
      );
    }
  }

  void reset() => emit(
        UnitManagingState(),
      );
}
