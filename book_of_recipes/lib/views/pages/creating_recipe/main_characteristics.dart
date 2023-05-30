import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../services/input_formatters.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/picker_dialog.dart';
import 'creating_recipe_cubit.dart';

class MainCharacteristics extends StatefulWidget {
  const MainCharacteristics({Key? key}) : super(key: key);

  @override
  State<MainCharacteristics> createState() => _MainCharacteristicsState();
}

class _MainCharacteristicsState extends State<MainCharacteristics> {
  late final GlobalKey<FormState> _nameTextFieldKey;
  late final GlobalKey<FormState> _descriptionTextFieldKey;
  late final GlobalKey<FormState> _servingsKey;
  late final GlobalKey<FormState> _timeKey;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _servingsController;
  late final TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _nameTextFieldKey = GlobalKey<FormState>();
    _descriptionTextFieldKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _servingsKey = GlobalKey<FormState>();
    _servingsController = TextEditingController();
    _timeKey = GlobalKey<FormState>();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _servingsController.dispose();
  }

  Widget _body(CreatingRecipeState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              _nameTextField(),
            ],
          ),
          _resultImage(state),
          Row(
            children: [
              _descriptionTextField(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: Row(
              children: [
                _timeAmountTextField(),
                _timeDropDown(state),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                _numberOfServingsField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Form(
          key: _nameTextFieldKey,
          child: TextFormField(
            controller: _nameController,
            maxLines: null,
            maxLength: 128,
            cursorColor: accentColor,
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(
                color: Colors.white60,
                fontSize: 24,
              ),
              errorStyle: TextStyle(
                fontSize: 16,
              ),
              focusColor: accentColor,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: accentColor,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 5) {
                return 'Name should be at least 5 symbols!';
              }
              return null;
            },
            onChanged: context.read<CreatingRecipeCubit>().nameChanged,
          ),
        ),
      ),
    );
  }

  Widget _resultImage(CreatingRecipeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: _showDialog,
            child: Container(
              margin: const EdgeInsets.only(
                top: 24,
                bottom: 24,
              ),
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(24),
                image: state.photoResult != ''
                    ? state.photoResult.startsWith('https://firebasestorage')
                        ? DecorationImage(
                            image: NetworkImage(state.photoResult),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: FileImage(
                              File(
                                state.photoResult,
                              ),
                            ),
                            fit: BoxFit.cover,
                          )
                    : null,
              ),
              child: state.photoResult == ''
                  ? const Center(
                      child: Icon(
                        Icons.photo,
                        size: 128,
                        color: Colors.white38,
                      ),
                    )
                  : null,
            ),
          ),
          const Text(
            'Result image',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDialog() {
    return showPickerDialog(
      context: context,
      onGalleryTap: () {
        context.read<CreatingRecipeCubit>().pickImage(true);
        Navigator.pop(context);
      },
      onCameraTap: () {
        context.read<CreatingRecipeCubit>().pickImage(false);
        Navigator.pop(context);
      },
    );
  }

  Widget _descriptionTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _descriptionTextFieldKey,
          child: TextFormField(
            controller: _descriptionController,
            cursorColor: accentColor,
            maxLines: null,
            maxLength: 255,
            decoration: const InputDecoration(
              labelStyle: TextStyle(
                fontSize: 24,
                color: Colors.white60,
              ),
              labelText: 'Description',
              errorStyle: TextStyle(
                fontSize: 14,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: accentColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 5) {
                return 'Description should be at least 5 symbols!';
              }
              return null;
            },
            onChanged: context.read<CreatingRecipeCubit>().descriptionChanged,
          ),
        ),
      ),
    );
  }

  Widget _numberOfServingsField() {
    return Expanded(
      child: Form(
        key: _servingsKey,
        child: TextFormField(
          controller: _servingsController,
          cursorColor: accentColor,
          textAlign: TextAlign.start,
          inputFormatters: [NumberInputFormatter()],
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: accentColor,
              ),
            ),
            labelText: 'Number of servings',
            labelStyle: TextStyle(
              color: Colors.white60,
              fontSize: 24,
            ),
          ),
          onChanged: context.read<CreatingRecipeCubit>().numberOfServingChanged,
          validator: (value) {
            if (value == null || value == '') {
              return 'Number of servings has to be not null!';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _timeAmountTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0),
        child: Form(
          key: _timeKey,
          child: TextFormField(
            controller: _timeController,
            cursorColor: accentColor,
            textAlign: TextAlign.start,
            inputFormatters: [NumberInputFormatter()],
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: accentColor,
                ),
              ),
              labelText: 'Cooking time',
              labelStyle: TextStyle(
                color: Colors.white60,
                fontSize: 24,
              ),
            ),
            onChanged:
                context.read<CreatingRecipeCubit>().cookingTimeAmountChanged,
            validator: (value) {
              if (value == null || value == '') {
                return 'Cooking time has to be not null!';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _timeDropDown(CreatingRecipeState state) {
    return Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: timeChoices
              .map(
                (time) => DropdownMenuItem(
                  value: time,
                  child: Text(
                    time,
                  ),
                ),
              )
              .toList(),
          value: state.currentTimeChoice,
          onChanged: (value) => context
              .read<CreatingRecipeCubit>()
              .currentTimeChoiceChanged(value as String),
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white38,
            ),
            elevation: 2,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white38,
            ),
            elevation: 8,
            offset: const Offset(-15, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(
              left: 14,
              right: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nextButton(CreatingRecipeState state) {
    return CustomFloatingActionButton(
      icon: Icons.arrow_forward,
      onPressed: () {
        if (_nameTextFieldKey.currentState!.validate() &&
            _descriptionTextFieldKey.currentState!.validate() &&
            _servingsKey.currentState!.validate() &&
            _timeKey.currentState!.validate()) {
          if (state.photoResult == '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey[800],
                duration: const Duration(seconds: 1),
                content: const Text(
                  'Photo result must be not null!',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          } else {
            if (state.numberOfServing <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey[800],
                  duration: const Duration(seconds: 1),
                  content: const Text(
                    'Number of servings must be grater than 0!',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            } else {
              if (state.cookingTimeAmount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.grey[800],
                    duration: const Duration(seconds: 1),
                    content: const Text(
                      'Cooking time must be grater than 0!',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              } else {
                context.read<CreatingRecipeCubit>().nextStage();
              }
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatingRecipeCubit, CreatingRecipeState>(
      builder: (context, state) {
        final name = state.name;
        if (name != '') {
          _nameController.value = TextEditingValue(
            text: name,
            selection: TextSelection.collapsed(
              offset: _nameController.text.length,
            ),
          );
        }
        final description = state.description;
        if (description != '') {
          _descriptionController.value = TextEditingValue(
            text: description,
            selection: TextSelection.collapsed(
              offset: _descriptionController.text.length,
            ),
          );
        }

        final number = state.numberOfServing;
        if (number != 0) {
          _servingsController.value = TextEditingValue(
            text: number.toString(),
            selection: TextSelection.collapsed(
              offset: _servingsController.text.length,
            ),
          );
        }
        final timeAmount = state.cookingTimeAmount;
        if (timeAmount != 0) {
          _timeController.value = TextEditingValue(
            text: timeAmount.toString(),
            selection: TextSelection.collapsed(
              offset: _timeController.text.length,
            ),
          );
        }

        return Scaffold(
          body: _body(state),
          floatingActionButton: _nextButton(state),
        );
      },
    );
  }
}
