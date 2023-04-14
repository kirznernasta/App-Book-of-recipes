import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../discover/discover.dart';
import '../favourite/favourite.dart';
import '../home/home.dart';
import '../profile/profile.dart';
import '../shopping_list/shopping_list.dart';
import 'main_page_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _body(int index) {
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const ShoppingList();
    } else if (index == 2) {
      return const Favourite();
    } else if (index == 3) {
      return const Discover();
    } else if (index == 4) {
      return const Profile();
    }
    throw Exception('Invalid index!');
  }

  BottomNavigationBar _bottomNavigationBar(MainPageState state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _homeItem(),
        _shoppingItem(),
        _favouritesItem(),
        _searchItem(),
        _profileItem(),
      ],
      currentIndex: state.selectedIndex,
      unselectedItemColor: iconNotActiveColor,
      selectedItemColor: accentColor,
      selectedIconTheme: const IconThemeData(
        color: accentColor,
      ),
      onTap: context.read<MainPageCubit>().changeSelectedIndex,
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

  BottomNavigationBarItem _searchItem() {
    return const BottomNavigationBarItem(
      label: 'search',
      icon: Icon(
        Icons.search,
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
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) => Scaffold(
        body: _body(state.selectedIndex),
        bottomNavigationBar: _bottomNavigationBar(state),
      ),
    );
  }
}
