import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/picker_dialog.dart';
import 'product_managing_cubit.dart';

class ProductManagingPage extends StatefulWidget {
  final bool isAdmin;
  final bool isEditing;
  final Product? editingProduct;

  const ProductManagingPage({
    this.isAdmin = false,
    this.isEditing = false,
    this.editingProduct,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductManagingPage> createState() => _ProductManagingPageState();
}

class _ProductManagingPageState extends State<ProductManagingPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _textEditingController = TextEditingController();
    if (widget.isEditing && widget.editingProduct != null) {
      _textEditingController.text = widget.editingProduct!.name;
    }
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _body(ProductManagingState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
              bottom: 48,
            ),
            child: _nameField(state),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: _imageField(state),
          ),
          if (state.isTryingCreate || state.isCreatedSuccessfully)
            _loadingAnimation(state),
        ],
      ),
    );
  }

  Widget _nameField(ProductManagingState state) {
    return Row(
      children: [
        const Text(
          'Name: ',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                focusNode: _focusNode,
                controller: _textEditingController,
                onChanged: context.read<ProductManagingCubit>().onNameChanged,
                validator: (_) {
                  return state.errorMessage == '' ? null : state.errorMessage;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageField(ProductManagingState state) {
    return Row(
      children: [
        const Text(
          'Image: ',
        ),
        GestureDetector(
          onTap: onImageTap,
          child: Container(
            margin: const EdgeInsets.only(
              left: 96,
            ),
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(160),
              image: widget.isEditing && state.image == ''
                  ? DecorationImage(
                      image: NetworkImage(
                        widget.editingProduct!.image,
                      ),
                      fit: BoxFit.cover,
                    )
                  : state.image != ''
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
            child: state.image == '' && !widget.isEditing
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 80,
                      ),
                    ],
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Future<String?> onImageTap() {
    return showPickerDialog(
      context: context,
      onGalleryTap: () {
        context.read<ProductManagingCubit>().pickImage(true);
        Navigator.pop(context);
      },
      onCameraTap: () {
        context.read<ProductManagingCubit>().pickImage(false);
        Navigator.pop(context);
      },
    );
  }

  Widget _loadingAnimation(ProductManagingState state) {
    if (state.isCreatedSuccessfully) {
      Future.delayed(const Duration(milliseconds: 50)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Created successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey[800],
            duration: const Duration(seconds: 1),
          ),
        );
        context.read<ProductManagingCubit>().reset();
        _textEditingController.text = '';
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

  Widget _floatingActionButton(ProductManagingState state) {
    return CustomFloatingActionButton(
      icon: state.isCanCreate ||
              widget.isEditing && _textEditingController.text != ''
          ? Icons.check
          : Icons.close,
      onPressed: () {
        if (state.isCanCreate && !state.isTryingCreate) {
          _focusNode.unfocus();
          context.read<ProductManagingCubit>().onApplyButton(
                isEditing: widget.isEditing,
                isAdmin: widget.isAdmin,
                product: widget.editingProduct,
              );
          Future.delayed(const Duration(milliseconds: 10),
              _formKey.currentState!.validate);

          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagingCubit, ProductManagingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(
            title: widget.isEditing
                ? 'Editing ${widget.editingProduct!.name}'
                : 'Product creation',
            context: context,
          ),
          body: _body(state),
          floatingActionButton: _floatingActionButton(state),
        );
      },
    );
  }
}
