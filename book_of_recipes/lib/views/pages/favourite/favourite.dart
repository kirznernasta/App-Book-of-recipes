import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'favourite_cubit.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text(
        'Favourite recipes',
        style: TextStyle(
          color: accentColor,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _searchTextField(),
        _favouritesListView(),
      ],
    );
  }

  Widget _searchTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
            ),
            hintText: 'Search recipes...',
          ),
        ),
      ),
    );
  }

  Widget _favouritesListView() {
    return Expanded(
      flex: 5,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          margin: const EdgeInsets.only(
            bottom: 16,
            left: 8,
            right: 8,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
          child: const Placeholder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  }
}
