part of 'step_managing_cubit.dart';

class StepManagingState {
  final String description;
  final String imagePath;

  StepManagingState({
    this.description = '',
    this.imagePath = '',
  });

  bool get canApply => description != '' && imagePath != '';

  StepManagingState copyWith({
    String? newDescription,
    String? newImage,
  }) =>
      StepManagingState(
        description: newDescription ?? description,
        imagePath: newImage ?? imagePath,
      );
}
