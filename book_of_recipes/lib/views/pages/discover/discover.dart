import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'discover_cubit.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text(
        'Discover recipes',
        style: TextStyle(
          color: accentColor,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _searchField(),
        _mostLiked(),
        _mostLikedListView(),
        _popularSearches(),
        _popularSearchesWrap(),
      ],
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16,
      ),
      child: Row(
        children: [
          _searchTextField(),
          _filterButton(),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return Expanded(
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
    );
  }

  Widget _filterButton() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            48,
          ),
        ),
        color: accentColor,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.tune,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _mostLiked() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Most liked',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mostLikedListView() {
    return Expanded(
      flex: 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          width: 160,
          margin: const EdgeInsets.all(
            8,
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

  Widget _popularSearches() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularSearchesWrap() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 16,
          runSpacing: 16,
          children: [
            for (var i = 0; i < 5; i++)
              Container(
                height: 32,
                width: 48.0 * (i + 1),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                child: const Placeholder(),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          body: _body(),
        );
      },
    );
  }
}
