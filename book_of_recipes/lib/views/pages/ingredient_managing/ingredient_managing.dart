import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/ingredient.dart';
import '../../../models/product.dart';
import '../../../services/input_formatters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../published_products/published_products_page.dart';
import 'ingredient_managing_cubit.dart';

class IngredientManagingPage extends StatefulWidget {
  final bool isCreating;
  final Ingredient? editingIngredient;
  final List<String> existingProductNames;
  const IngredientManagingPage({
    required this.existingProductNames,
    this.isCreating = true,
    this.editingIngredient,
    Key? key,
  }) : super(key: key);

  @override
  State<IngredientManagingPage> createState() => _IngredientManagingPageState();
}

class _IngredientManagingPageState extends State<IngredientManagingPage> {
  late final TextEditingController _controller;
  late final GlobalKey<FormState> _amountKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _amountKey = GlobalKey<FormState>();

    if (!widget.isCreating) {
      context.read<IngredientManagingCubit>().setIngredientProperties(
            productName: widget.editingIngredient!.productName,
            productImage: widget.editingIngredient!.productImage,
            amount: widget.editingIngredient!.amount,
            existingProductNames: widget.existingProductNames,
            unitName: widget.editingIngredient!.unitName,
          );
      _controller.text = widget.editingIngredient!.amount.toString();
    } else {
      context.read<IngredientManagingCubit>().setExistingProductNames(
            widget.existingProductNames,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientManagingCubit, IngredientManagingState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            context.read<IngredientManagingCubit>().reset();
            return Future.value(true);
          },
          child: Scaffold(
            appBar: customAppBar(
              title: widget.isCreating
                  ? 'Ingredient creation'
                  : 'Editing ${widget.editingIngredient?.productName}',
              context: context,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // ignore: omit_local_variable_types
                        Product? product = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PublishedProductsPage(
                              isCreatingIngredient: true,
                            ),
                          ),
                        );
                        if (product != null) {
                          context
                              .read<IngredientManagingCubit>()
                              .setProductProperties(product);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        height: 48,
                        width: MediaQuery.of(context).size.width -
                            24 -
                            24 -
                            48 -
                            72,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                              'Tap to ${state.productName == '' ? 'select' : 'change'} a product'),
                        ),
                      ),
                    ),
                    Text(
                      'Product: ${state.productName == '' ? 'UNSELECTED' : state.productName}',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 24,
                      ),
                    ),
                    if (state.productImage != '')
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(160),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.productImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Form(
                            key: _amountKey,
                            child: Expanded(
                              child: TextFormField(
                                controller: _controller,
                                cursorColor: accentColor,
                                textAlign: TextAlign.end,
                                inputFormatters: [DoubleInputFormatter()],
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: accentColor,
                                    ),
                                  ),
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 24,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Number of servings has to be not null!';
                                  }
                                  return null;
                                },
                                onChanged: context
                                    .read<IngredientManagingCubit>()
                                    .amountChanged,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: state.units
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit.name,
                                          child: Text(
                                            unit.name,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: state.selectedUnit,
                                  onChanged: (value) => context
                                      .read<IngredientManagingCubit>()
                                      .selectedUnitChanged(value as String),
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
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: CustomFloatingActionButton(
              icon: state.isCanApply ? Icons.check : Icons.close,
              onPressed: () {
                if (state.isIngredientAlreadyExist &&
                    widget.isCreating &&
                    state.isCanApply) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Ingredient with product already exists!',
                        style: TextStyle(color: Colors.red),
                      ),
                      backgroundColor: Colors.grey[800],
                      duration: const Duration(seconds: 1),
                    ),
                  );
                } else {
                  // ignore: omit_local_variable_types
                  Ingredient? ingredient = state.isCanApply
                      ? Ingredient(
                          id: widget.isCreating
                              ? ''
                              : widget.editingIngredient!.id,
                          productName: state.productName,
                          productImage: state.productImage,
                          amount: state.amount,
                          unitName: state.selectedUnit,
                          recipeId: widget.isCreating
                              ? ''
                              : widget.editingIngredient!.recipeId,
                        )
                      : null;
                  context.read<IngredientManagingCubit>().reset();
                  Navigator.pop(
                    context,
                    ingredient,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
