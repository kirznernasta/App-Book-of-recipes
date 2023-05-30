import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/product.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/product_card.dart';
import '../../widgets/published_item_menu.dart';
import '../../widgets/search_field.dart';
import '../product_managing/product_managing_page.dart';
import 'published_products_cubit.dart';

class PublishedProductsPage extends StatelessWidget {
  final bool isCreatingIngredient;

  const PublishedProductsPage({
    this.isCreatingIngredient = false,
    Key? key,
  }) : super(key: key);

  Widget _body(BuildContext context, PublishedProductsState state) {
    return Column(
      children: [
        _searchField(context),
        _productsListView(context, state),
      ],
    );
  }

  Widget _searchField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            SearchField(
              hintText: 'Search products...',
              onChanged: context.read<PublishedProductsCubit>().requestChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _productsListView(BuildContext context, PublishedProductsState state) {
    if (state.products.isNotEmpty) {
      return Expanded(
        flex: 7,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.products.length,
          itemBuilder: (_, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _product(
                context: context,
                index: index,
                state: state,
              ),
              const Divider(),
            ],
          ),
        ),
      );
    }
    if (state.products.isEmpty) {
      return const Expanded(
        flex: 7,
        child: HintCard(
          text: 'Products are empty. Create a new one to see it here.',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white30,
          ),
          isMaxWidth: true,
        ),
      );
    }

    return const Expanded(
      flex: 7,
      child: HintCard(
        text: 'No products with this request found',
        style: TextStyle(
          fontSize: 32,
          color: Colors.white30,
        ),
        icon: Icon(
          Icons.search,
          color: accentColor,
          size: 96,
        ),
        isMaxWidth: true,
      ),
    );
  }

  Widget _product({
    required BuildContext context,
    required int index,
    required PublishedProductsState state,
  }) {
    return ProductCard(
      name: state.products[index].name,
      imageUrl: state.products[index].image,
      onLongPress: () {
        _showMenu(
          context: context,
          index: index,
          state: state,
        );
      },
      onTap: () => isCreatingIngredient
          ? context.read<PublishedProductsCubit>().toggleSelectedProduct(index)
          : null,
      isSelected: index == state.selectedIndex,
    );
  }

  void _showMenu({
    required BuildContext context,
    required int index,
    required PublishedProductsState state,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PublishedItemMenuBuilder(
        onEditTap: () => _onEditTap(
          context: context,
          index: index,
          state: state,
        ),
        onDeleteTap: () => _onDeleteTap(
          context: context,
          index: index,
          state: state,
        ),
      ),
    );
  }

  void _onEditTap({
    required BuildContext context,
    required int index,
    required PublishedProductsState state,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductManagingPage(
          isEditing: true,
          editingProduct: state.products[index],
          isAdmin: true,
        ),
      ),
    );
    Navigator.pop(context);
  }

  void _onDeleteTap({
    required BuildContext context,
    required int index,
    required PublishedProductsState state,
  }) {
    Navigator.pop(context);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Delete this product?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              await context.read<PublishedProductsCubit>().deleteProduct(index);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishedProductsCubit, PublishedProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Published products', context: context),
          body: _body(context, state),
          floatingActionButton: CustomFloatingActionButton(
            icon: !isCreatingIngredient
                ? Icons.add
                : state.selectedIndex != -1
                    ? Icons.check
                    : Icons.close,
            onPressed: () {
              if (!isCreatingIngredient) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductManagingPage(
                      isEditing: false,
                      isAdmin: true,
                    ),
                  ),
                );
              } else {
                // ignore: omit_local_variable_types
                Product? product = state.selectedIndex == -1
                    ? null
                    : state.products[state.selectedIndex];
                context.read<PublishedProductsCubit>().resetSelectedProduct();

                Navigator.pop(context, product);
              }
            },
          ),
        );
      },
    );
  }
}
