import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'presentation/pages/discover/discover_cubit.dart';
import 'presentation/pages/favourite/favourite_cubit.dart';
import 'presentation/pages/home/home_cubit.dart';
import 'presentation/pages/main_page/main_page.dart';
import 'presentation/pages/main_page/main_page_cubit.dart';
import 'presentation/pages/profile/profile_cubit.dart';
import 'presentation/pages/shopping_list/shopping_list_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainPageCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (_) => ShoppingListCubit(),
        ),
        BlocProvider(
          create: (_) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (_) => DiscoverCubit(),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book of recipes',
        home: const MainPage(),
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark().copyWith(
          primaryColor: accentColor,
          useMaterial3: true,
        ),
      ),
    );
  }
}
