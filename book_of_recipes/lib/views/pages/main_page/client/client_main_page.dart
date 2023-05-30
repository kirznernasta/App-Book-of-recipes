import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../models/user.dart';
import '../../favourite/favourite.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
import '../../shopping_list/shopping_list.dart';
import 'client_main_page_cubit.dart';

class ClientMainPage extends StatelessWidget {
  final User user;

  const ClientMainPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  Widget _body(int index) {
    if (index == 0) {
      return Home(
        user: user,
      );
    }
    if (index == 1) {
      return const ShoppingList();
    }
    if (index == 2) {
      return Favourite(userId: user.id);
    }
    if (index == 3) {
      return Profile(
        user: user,
      );
    }
    throw Exception('Invalid index!');
  }

  BottomNavigationBar _bottomNavigationBar(
      BuildContext context, ClientMainPageState state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _homeItem(),
        _shoppingItem(),
        _favouritesItem(),
        _profileItem(),
      ],
      currentIndex: state.selectedIndex,
      unselectedItemColor: iconNotActiveColor,
      selectedItemColor: accentColor,
      selectedIconTheme: const IconThemeData(
        color: accentColor,
      ),
      onTap: context.read<ClientMainPageCubit>().changeSelectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _homeItem() {
    return const BottomNavigationBarItem(
      label: 'home',
      icon: Icon(
        Icons.home_outlined,
      ),
      activeIcon: Icon(
        Icons.home,
      ),
    );
  }

  BottomNavigationBarItem _shoppingItem() {
    return const BottomNavigationBarItem(
      label: 'shopping',
      icon: Icon(
        Icons.storefront_outlined,
      ),
      activeIcon: Icon(
        Icons.storefront_rounded,
      ),
    );
  }

  BottomNavigationBarItem _favouritesItem() {
    return const BottomNavigationBarItem(
      label: 'favourites',
      icon: Icon(
        Icons.favorite_border_outlined,
      ),
      activeIcon: Icon(
        Icons.favorite,
      ),
    );
  }

  BottomNavigationBarItem _profileItem() {
    return const BottomNavigationBarItem(
      label: 'profile',
      icon: Icon(
        Icons.person_2_outlined,
      ),
      activeIcon: Icon(
        Icons.person,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientMainPageCubit, ClientMainPageState>(
      builder: (context, state) => Scaffold(
        body: _body(state.selectedIndex),
        bottomNavigationBar: _bottomNavigationBar(context, state),
      ),
    );
  }
}
