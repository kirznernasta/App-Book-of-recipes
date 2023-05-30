import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../models/user.dart';
import '../../published_products/published_products_page.dart';
import '../../published_recipes/published_recipes_page.dart';
import '../../published_units/published_units_page.dart';
import 'admin_main_page_cubit.dart';

class AdminMainPage extends StatelessWidget {
  final User admin;
  const AdminMainPage({required this.admin, Key? key}) : super(key: key);

  final BottomNavigationBarItem _recipesItem = const BottomNavigationBarItem(
    label: 'recipes',
    icon: Icon(
      Icons.menu_book_outlined,
    ),
    activeIcon: Icon(
      Icons.menu_book,
    ),
  );

  final BottomNavigationBarItem _productsItem = const BottomNavigationBarItem(
    label: 'products',
    icon: Icon(
      Icons.fastfood_outlined,
    ),
    activeIcon: Icon(
      Icons.fastfood,
    ),
  );

  final _unitsItem = const BottomNavigationBarItem(
    label: 'units',
    icon: Icon(
      Icons.ad_units_outlined,
    ),
    activeIcon: Icon(
      Icons.ad_units,
    ),
  );

  Widget _body(int index) {
    if (index == 0) {
      return const PublishedRecipesPage();
    } else if (index == 1) {
      return const PublishedProductsPage();
    } else if (index == 2) {
      return const PublishedUnitsPage();
    }
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Admin',
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(
      BuildContext context, AdminMainPageState state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _recipesItem,
        _productsItem,
        _unitsItem,
      ],
      currentIndex: state.selectedIndex,
      unselectedItemColor: iconNotActiveColor,
      selectedItemColor: accentColor,
      selectedIconTheme: const IconThemeData(
        color: accentColor,
      ),
      onTap: context.read<AdminMainPageCubit>().changeSelectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminMainPageCubit, AdminMainPageState>(
      builder: (context, state) => Scaffold(
        body: _body(state.selectedIndex),
        bottomNavigationBar: _bottomNavigationBar(context, state),
      ),
    );
  }
}
