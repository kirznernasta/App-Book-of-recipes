import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/image_picker.dart';

part 'step_managing_state.dart';

class StepManagingCubit extends Cubit<StepManagingState> {
  StepManagingCubit() : super(StepManagingState());

  void setStepProperties(
          {required String description, required String imagePath}) =>
      emit(
        state.copyWith(
          newDescription: description,
          newImage: imagePath,
        ),
      );

  void descriptionChanged(String value) => emit(
        state.copyWith(
          newDescription: value,
        ),
      );

  Future<void> pickImage(bool isFromGallery) async {
    final pickedFile =
        await ImagePicker.pickImage(isFromGallery: isFromGallery);
    if (pickedFile != null) {
      emit(
        state.copyWith(
          newImage: pickedFile.path,
        ),
      );
    }
  }

  void reset() => emit(StepManagingState());
}
