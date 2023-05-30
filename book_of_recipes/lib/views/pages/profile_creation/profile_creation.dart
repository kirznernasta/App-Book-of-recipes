import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/picker_dialog.dart';
import '../main_page/main_page.dart';
import 'profile_creation_cubit.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  final _formKey = GlobalKey<FormState>();

  Widget _body(BuildContext context, ProfileCreationState state) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: state.isTryingCreate || state.isCreateSuccessful
              ? [
                  _loadingAnimation(context, state),
                ]
              : [
                  _hintCard(),
                  _profileInfo(state),
                  _applyButton(state),
                ],
        ),
      ),
    );
  }

  Widget _loadingAnimation(BuildContext context, ProfileCreationState state) {
    if (state.isCreateSuccessful) {
      Future.delayed(const Duration(milliseconds: 5), () async {
        final user = await context.read<ProfileCreationCubit>().updatedUser();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MainPage(user: user),
          ),
        );
      });
    }
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 120,
        top: 48,
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _hintCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      color: accentColor.withOpacity(0.2),
      child: Row(
        children: [
          _hintIcon(),
          _hintText(),
        ],
      ),
    );
  }

  Widget _hintIcon() {
    return const Icon(
      Icons.tips_and_updates,
      color: accentColor,
      size: 32,
    );
  }

  Widget _hintText() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          'Add image to your profile and create your username.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _profileInfo(ProfileCreationState state) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 160,
        left: 24,
        right: 24,
      ),
      child: Row(
        children: [
          _userImage(state),
          _usernameTextField(state),
        ],
      ),
    );
  }

  Widget _userImage(ProfileCreationState state) {
    return GestureDetector(
      onTap: _showDialog,
      child: Container(
        margin: const EdgeInsets.only(
          right: 16,
        ),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56),
          color: Colors.grey,
          image: state.image != ''
              ? DecorationImage(
                  image: FileImage(
                    File(
                      state.image,
                    ),
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: state.image == ''
            ? const Center(
                child: Icon(
                  Icons.person,
                  size: 48,
                ),
              )
            : null,
      ),
    );
  }

  Future<String?> _showDialog() {
    return showPickerDialog(
      context: context,
      onGalleryTap: () {
        context.read<ProfileCreationCubit>().pickImage(true);
        Navigator.pop(context);
      },
      onCameraTap: () {
        context.read<ProfileCreationCubit>().pickImage(false);
        Navigator.pop(context);
      },
    );
  }

  Widget _usernameTextField(ProfileCreationState state) {
    return Expanded(
      child: TextFormField(
        cursorColor: accentColor,
        decoration: const InputDecoration(
          hintText: 'username',
          errorStyle: TextStyle(
            fontSize: 16,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: accentColor,
            ),
          ),
        ),
        validator: (value) {
          if (value == null) {
            return 'Username must be not empty.';
          } else {
            return state.errorMessage == '' ? null : state.errorMessage;
          }
        },
        onChanged: context.read<ProfileCreationCubit>().usernameChanged,
      ),
    );
  }

  Widget _applyButton(ProfileCreationState state) {
    return GestureDetector(
      onTap: () async {
        context.read<ProfileCreationCubit>().validator().then(
              (_) => _formKey.currentState!.validate(),
            );
      },
      child: Container(
        width: 350,
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(
          bottom: 8,
          top: 48,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: const Center(
          child: Text(
            'Create',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCreationCubit, ProfileCreationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Profile creation', context: context),
          body: _body(context, state),
        );
      },
    );
  }
}
