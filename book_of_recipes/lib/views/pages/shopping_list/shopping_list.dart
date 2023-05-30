import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/product_card.dart';
import '../published_products/published_products_page.dart';
import 'shopping_list_cubit.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key? key}) : super(key: key);

  Widget _body(BuildContext context, ShoppingListState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8,
      ),
      child: _ingredientsView(context, state),
    );
  }

  Widget _ingredientsView(BuildContext context, ShoppingListState state) {
    if (state.shoppingProducts.isEmpty) {
      return const HintCard(
        text: 'Shopping list is empty. Add an item to see it here.',
        style: TextStyle(
          fontSize: 32,
          color: Colors.white30,
        ),
        isMaxWidth: true,
      );
    }
    return ListView.builder(
      itemCount: state.shoppingProducts.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: ValueKey<String>(state.shoppingProducts[index].id),
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.teal,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Done'),
              ],
            ),
          ),
          secondaryBackground: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.teal,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Done'),
              ],
            ),
          ),
          onDismissed: (_) {
            context.read<ShoppingListCubit>().removeProductFromList(
                  state.shoppingProducts[index],
                );
          },
          child: ProductCard(
            name: state.shoppingProducts[index].name,
            imageUrl: state.shoppingProducts[index].image,
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return CustomFloatingActionButton(
      icon: Icons.add,
      onPressed: () async {
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
          context.read<ShoppingListCubit>().addProductToList(product);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListCubit, ShoppingListState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Shopping list', context: context),
          body: _body(context, state),
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }
}
