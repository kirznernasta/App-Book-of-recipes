import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/firebase/authentication.dart';
import '../../../services/image_picker.dart';

part 'profile_creation_state.dart';

class ProfileCreationCubit extends Cubit<ProfileCreationState> {
  final UserRepository _userRepository;
  final Authentication _authentication;

  ProfileCreationCubit({
    required UserRepository userRepository,
    required Authentication authentication,
  })  : _userRepository = userRepository,
        _authentication = authentication,
        super(ProfileCreationState());

  Future<User?> updatedUser() async {
    final userId = _authentication.currentUser!.uid;
    return await _userRepository.receiveUserById(userId);
  }

  void usernameChanged(String value) => emit(
        state.copyWith(
          newUsername: value,
        ),
      );

  Future<void> validator() async {
    final value = state.username;
    final re = RegExp(r'\W');
    if (value == '') {
      emit(
        state.copyWith(
          newErrorMessage: 'Username must be not empty.',
        ),
      );
    } else if (re.hasMatch(value)) {
      emit(
        state.copyWith(
          newErrorMessage: 'Invalid username.',
        ),
      );
    } else {
      final users = await _userRepository.receiveAll();
      if (users.map((user) => user.name).contains(value)) {
        emit(
          state.copyWith(
            newErrorMessage: 'Username is already exists.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            newErrorMessage: '',
            tryingCreate: true,
          ),
        );
        _createProfile().then(
          (_) => emit(
            state.copyWith(
              newErrorMessage: '',
              tryingCreate: false,
              createSuccessful: true,
            ),
          ),
        );
      }
    }
  }

  Future<void> _createProfile() async {
    final user = User(
      id: _authentication.currentUser!.uid,
      name: state.username,
      email: _authentication.currentUser!.email!,
      image: state.image,
      isAdmin: false,
      favouriteRecipeIds: const [],
    );
    await _userRepository.add(user);
    final updatedUser = await _userRepository.receiveUserById(user.id);
    return await _authentication.updateProfile(
      image: updatedUser!.image,
      username: updatedUser.name,
    );
  }

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
}
