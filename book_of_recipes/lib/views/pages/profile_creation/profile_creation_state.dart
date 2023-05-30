part of 'profile_creation_cubit.dart';

class ProfileCreationState {
  final String username;
  final String image;
  final String errorMessage;
  final bool isTryingCreate;
  final bool isCreateSuccessful;

  ProfileCreationState({
    this.username = '',
    this.image = '',
    this.errorMessage = '',
    this.isTryingCreate = false,
    this.isCreateSuccessful = false,
  });

  ProfileCreationState copyWith({
    String? newUsername,
    String? newImage,
    String? newErrorMessage,
    bool? tryingCreate,
    bool? createSuccessful,
  }) =>
      ProfileCreationState(
        username: newUsername ?? username,
        image: newImage ?? image,
        errorMessage: newErrorMessage ?? errorMessage,
        isTryingCreate: tryingCreate ?? isTryingCreate,
        isCreateSuccessful: createSuccessful ?? isCreateSuccessful,
      );
}
