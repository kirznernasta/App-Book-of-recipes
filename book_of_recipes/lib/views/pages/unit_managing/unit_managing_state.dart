part of 'unit_managing_cubit.dart';

class UnitManagingState {
  final String name;
  final String errorMessage;
  final bool isTrying;
  final bool isTrySuccessful;

  UnitManagingState({
    this.name = '',
    this.errorMessage = '',
    this.isTrying = false,
    this.isTrySuccessful = false,
  });

  UnitManagingState copyWith({
    String? newName,
    String? newErrorMessage,
    bool? tryingCreate,
    bool? createdSuccessfully,
  }) =>
      UnitManagingState(
        name: newName ?? name,
        errorMessage: newErrorMessage ?? errorMessage,
        isTrying: tryingCreate ?? isTrying,
        isTrySuccessful: createdSuccessfully ?? isTrySuccessful,
      );
}
