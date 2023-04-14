import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'shopping_list_cubit.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text(
        'Shopping list',
        style: TextStyle(
          color: accentColor,
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8,
      ),
      child: _ingredientsView(),
    );
  }

  Widget _ingredientsView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          width: 240,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16,
            ),
            color: Colors.teal,
          ),
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: accentColor,
        elevation: 16,
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListCubit, ShoppingListState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: _appBar(context),
          body: _body(),
          floatingActionButton: _floatingActionButton(),
        );
      },
    );
  }
}
