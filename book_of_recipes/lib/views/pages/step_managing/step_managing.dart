import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/step.dart' as step;
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/picker_dialog.dart';
import 'step_managing_cubit.dart';

class StepManaging extends StatefulWidget {
  final bool isCreating;
  final step.Step? editingStep;

  const StepManaging({
    this.isCreating = true,
    this.editingStep,
    Key? key,
  }) : super(key: key);

  @override
  State<StepManaging> createState() => _StepManagingState();
}

class _StepManagingState extends State<StepManaging> {
  late final GlobalKey<FormState> _descriptionTextFieldKey;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _descriptionTextFieldKey = GlobalKey<FormState>();

    if (!widget.isCreating) {
      context.read<StepManagingCubit>().setStepProperties(
            description: widget.editingStep!.description,
            imagePath: widget.editingStep!.image,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Widget _resultImage(StepManagingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
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
                image: state.imagePath != ''
                    ? DecorationImage(
                        image: FileImage(
                          File(
                            state.imagePath,
                          ),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: state.imagePath == ''
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
            'Step image',
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
        context.read<StepManagingCubit>().pickImage(true);
        Navigator.pop(context);
      },
      onCameraTap: () {
        context.read<StepManagingCubit>().pickImage(false);
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
            maxLength: 512,
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
            onChanged: context.read<StepManagingCubit>().descriptionChanged,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepManagingCubit, StepManagingState>(
      builder: (_, state) {
        final description = state.description;
        if (description != '') {
          _descriptionController.value = TextEditingValue(
            text: description,
            selection: TextSelection.collapsed(
              offset: _descriptionController.text.length,
            ),
          );
        }

        return Scaffold(
          appBar: customAppBar(
              title: widget.isCreating ? 'Step creation' : 'Editing step',
              context: context),
          body: Column(
            children: [
              _resultImage(state),
              _descriptionTextField(),
            ],
          ),
          floatingActionButton: CustomFloatingActionButton(
            icon: state.canApply ? Icons.check : Icons.close,
            onPressed: () {
              // ignore: omit_local_variable_types
              step.Step? nextStep = state.canApply
                  ? step.Step(
                      id: widget.isCreating ? '' : widget.editingStep!.id,
                      number:
                          widget.isCreating ? 0 : widget.editingStep!.number,
                      description: state.description,
                      image: state.imagePath,
                      recipeId:
                          widget.isCreating ? '' : widget.editingStep!.recipeId,
                    )
                  : null;
              context.read<StepManagingCubit>().reset();
              Navigator.pop(context, nextStep);
            },
          ),
        );
      },
    );
  }
}
