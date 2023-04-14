import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'services/firebase/authentication.dart';
import 'views/pages/discover/discover_cubit.dart';
import 'views/pages/email_verification/email_verification_cubit.dart';
import 'views/pages/favourite/favourite_cubit.dart';
import 'views/pages/home/home_cubit.dart';
import 'views/pages/login/login_cubit.dart';
import 'views/pages/main_page/main_page_cubit.dart';
import 'views/pages/profile/profile_cubit.dart';
import 'views/pages/shopping_list/shopping_list_cubit.dart';
import 'views/pages/sing_up/sign_up_cubit.dart';
import 'views/pages/welcome/welcome.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Authentication authentication;

  @override
  void initState() {
    super.initState();
    authentication = Authentication();
  }

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
        BlocProvider(
          create: (_) => SignUpCubit(
            firebaseAuthentication: authentication,
          ),
        ),
        BlocProvider(
          create: (_) => EmailVerificationCubit(
            firebaseAuthentication: authentication,
          ),
        ),
        BlocProvider(
          create: (_) => LoginCubit(
            firebaseAuthentication: authentication,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book of recipes',
        home: const Welcome(),
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark().copyWith(
          primaryColor: accentColor,
          useMaterial3: true,
        ),
      ),
    );
  }
}
