import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'profile_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: const IconThemeData(
        color: accentColor,
      ),
      title: const Text(
        'Account',
        style: TextStyle(
          color: accentColor,
        ),
      ),
    );
  }

  Drawer _drawer() {
    return const Drawer();
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _userImage(),
        _username(),
        _statistics(),
        _addRecipeButton(),
        _seeAllMyRecipesButton(),
        _myRecipesListView(),
      ],
    );
  }

  Widget _userImage() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        width: 96,
        height: 96,
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(
            Radius.circular(
              96,
            ),
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'USER NAME',
      ),
    );
  }

  Widget _statistics() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(
          48,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _publishedRecipes(),
          _divider(),
          _likes(),
        ],
      ),
    );
  }

  Widget _publishedRecipes() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'NUMBER',
          ),
          Text(
            'Published recipes',
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 80,
      width: 2,
      color: Colors.grey[300],
    );
  }

  Widget _likes() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 64.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'NUMBER',
          ),
          Text(
            'Likes',
          ),
        ],
      ),
    );
  }

  Widget _addRecipeButton() {
    return Container(
      width: 160,
      height: 48,
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
        color: accentColor,
      ),
      child: const Center(
        child: Text(
          'Add recipe',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _seeAllMyRecipesButton() {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'See all my recipies',
            style: TextStyle(
              color: accentColor,
              decoration: TextDecoration.underline,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _myRecipesListView() {
    return Expanded(
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          drawer: _drawer(),
          body: _body(),
        );
      },
    );
  }
}
