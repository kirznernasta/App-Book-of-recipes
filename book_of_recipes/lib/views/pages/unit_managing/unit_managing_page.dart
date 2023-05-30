import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/unit.dart';
import '../../widgets/custom_app_bar.dart';
import 'unit_managing_cubit.dart';

class UnitManagingPage extends StatefulWidget {
  final bool isCreating;
  final Unit? editingUnit;

  const UnitManagingPage({
    required this.isCreating,
    this.editingUnit,
    Key? key,
  }) : super(key: key);

  @override
  State<UnitManagingPage> createState() => _UnitManagingPageState();
}

class _UnitManagingPageState extends State<UnitManagingPage> {
  late final GlobalKey<FormState> _nameTextFieldKey;
  late final TextEditingController _nameController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _nameTextFieldKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _focusNode = FocusNode();

    if (!widget.isCreating && widget.editingUnit != null) {
      _nameController.text = widget.editingUnit!.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context, UnitManagingState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: _nameField(state),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _onApplyTap(state),
            child: _applyButton(),
          ),
          if (state.isTrying || state.isTrySuccessful) _loadingAnimation(state),
        ],
      ),
    );
  }

  Widget _nameField(UnitManagingState state) {
    return Form(
      key: _nameTextFieldKey,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _nameController,
        maxLines: 1,
        maxLength: 24,
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
          if (value == null || value == '') {
            return 'Name should be not null!';
          }
          return state.errorMessage == '' ? null : state.errorMessage;
        },
        onChanged: context.read<UnitManagingCubit>().nameChanged,
      ),
    );
  }

  void _onApplyTap(UnitManagingState state) {
    if (_nameController.text == '') {
      _nameTextFieldKey.currentState!.validate();
    }
    if (!state.isTrying || !widget.isCreating && _nameController.text != '') {
      _focusNode.unfocus();
      context.read<UnitManagingCubit>().onApplyButton(
            isCreating: widget.isCreating,
            unit: widget.editingUnit,
          );
      Future.delayed(const Duration(milliseconds: 60),
          _nameTextFieldKey.currentState!.validate);
    }
  }

  Widget _applyButton() {
    return Container(
      width: 128,
      height: 48,
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Center(
        child: Text(
          widget.isCreating ? 'Create Unit' : 'Edit Unit',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _loadingAnimation(UnitManagingState state) {
    if (state.isTrySuccessful) {
      Future.delayed(const Duration(milliseconds: 50)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(
              seconds: 2,
            ),
            content: Text(
              '${widget.isCreating ? 'Created' : 'Edited'} successfully!',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey[800],
          ),
        );

        context.read<UnitManagingCubit>().reset();
        _nameController.text = '';
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitManagingCubit, UnitManagingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(
              title: widget.isCreating
                  ? 'Unit creation'
                  : 'Editing ${widget.editingUnit!.name}',
              context: context),
          body: _body(context, state),
        );
      },
    );
  }
}
