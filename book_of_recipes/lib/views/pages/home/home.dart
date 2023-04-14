import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'home_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.all(
          4,
        ),
        child: _userImage(),
      ),
      title: const Text('Hi, username'),
    );
  }

  Widget _userImage() {
    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            32,
          ),
        ),
        color: Colors.teal,
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _title(),
        _searchField(),
        _trendingAndSeeAll(),
        _trendingListView(),
      ],
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'What you would like to cook today?',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: accentColor, fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _searchField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            _searchTextField(),
            _filterButton(),
          ],
        ),
      ),
    );
  }

  Widget _trendingAndSeeAll() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trending',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            _seeAllButton(),
          ],
        ),
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

  Widget _seeAllButton() {
    return GestureDetector(
      child: const Text(
        'See all',
        style: TextStyle(
          color: accentColor,
          decoration: TextDecoration.underline,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _trendingListView() {
    return Expanded(
      flex: 7,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, __) => Container(
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  }
}
