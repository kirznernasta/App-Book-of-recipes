import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'repositories/ingredient_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/recipe_repository.dart';
import 'repositories/step_repository.dart';
import 'repositories/unit_repository.dart';
import 'repositories/user_repository.dart';
import 'services/firebase/authentication.dart';
import 'services/firebase/database_provider.dart';
import 'services/firebase/storage_provider.dart';
import 'views/pages/creating_recipe/creating_recipe_cubit.dart';
import 'views/pages/email_verification/email_verification_cubit.dart';
import 'views/pages/favourite/favourite_cubit.dart';
import 'views/pages/home/home_cubit.dart';
import 'views/pages/ingredient_managing/ingredient_managing_cubit.dart';
import 'views/pages/login/login_cubit.dart';
import 'views/pages/main_page/admin/admin_main_page_cubit.dart';
import 'views/pages/main_page/client/client_main_page_cubit.dart';
import 'views/pages/managing_requests/managing_request_cubit.dart';
import 'views/pages/product_managing/product_managing_cubit.dart';
import 'views/pages/profile/profile_cubit.dart';
import 'views/pages/profile_creation/profile_creation_cubit.dart';
import 'views/pages/published_products/published_products_cubit.dart';
import 'views/pages/published_recipes/published_recipes_cubit.dart';
import 'views/pages/published_units/published_units_cubit.dart';
import 'views/pages/recipe_detail/recipe_page_cubit.dart';
import 'views/pages/shopping_list/shopping_list_cubit.dart';
import 'views/pages/sing_up/sign_up_cubit.dart';
import 'views/pages/step_managing/step_managing_cubit.dart';
import 'views/pages/unit_managing/unit_managing_cubit.dart';
import 'views/pages/welcome/welcome.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Authentication _authentication;
  late final StorageProvider _storageProvider;
  late final DatabaseProvider _databaseProvider;
  late final UserRepository _userRepository;
  late final ProductRepository _productRepository;
  late final UnitRepository _unitRepository;
  late final RecipeRepository _recipeRepository;
  late final IngredientRepository _ingredientRepository;
  late final StepRepository _stepRepository;

  @override
  void initState() {
    super.initState();
    _authentication = Authentication();
    _storageProvider = StorageProvider();
    _databaseProvider = DatabaseProvider(
        authentication: _authentication, storageProvider: _storageProvider);
    _userRepository = UserRepository(databaseProvider: _databaseProvider);
    _productRepository = ProductRepository(databaseProvider: _databaseProvider);
    _recipeRepository = RecipeRepository(databaseProvider: _databaseProvider);
    _ingredientRepository =
        IngredientRepository(databaseProvider: _databaseProvider);
    _unitRepository = UnitRepository(databaseProvider: _databaseProvider);
    _stepRepository = StepRepository(databaseProvider: _databaseProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ClientMainPageCubit(),
        ),
        BlocProvider(
          create: (_) => AdminMainPageCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(
            userRepository: _userRepository,
            recipeRepository: _recipeRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ShoppingListCubit(
            productRepository: _productRepository,
          ),
        ),
        BlocProvider(
          create: (_) => FavouriteCubit(
            userRepository: _userRepository,
            recipeRepository: _recipeRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(),
        ),
        BlocProvider(
          create: (_) => SignUpCubit(
            firebaseAuthentication: _authentication,
          ),
        ),
        BlocProvider(
          create: (_) => EmailVerificationCubit(
            firebaseAuthentication: _authentication,
          ),
        ),
        BlocProvider(
          create: (_) => LoginCubit(
            userRepository: _userRepository,
            firebaseAuthentication: _authentication,
          ),
        ),
        BlocProvider(
          create: (_) => ProfileCreationCubit(
            authentication: _authentication,
            userRepository: _userRepository,
          ),
        ),
        BlocProvider(
          create: (_) => PublishedRecipesCubit(
            recipeRepository: _recipeRepository,
          ),
        ),
        BlocProvider(
          create: (_) => RecipePageCubit(
            ingredientRepository: _ingredientRepository,
            stepRepository: _stepRepository,
          ),
        ),
        BlocProvider(
          create: (_) => PublishedProductsCubit(
            productRepository: _productRepository,
          ),
        ),
        BlocProvider(
          create: (_) => PublishedUnitsCubit(
            unitRepository: _unitRepository,
          ),
        ),
        BlocProvider(
          create: (_) => UnitManagingCubit(
            unitRepository: _unitRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ManagingRequestCubit(),
        ),
        BlocProvider(
          create: (_) =>
              ProductManagingCubit(productRepository: _productRepository),
        ),
        BlocProvider(
          create: (_) => IngredientManagingCubit(
            unitRepository: _unitRepository,
          ),
        ),
        BlocProvider(
          create: (_) => StepManagingCubit(),
        ),
        BlocProvider(
          create: (_) => CreatingRecipeCubit(
            recipeRepository: _recipeRepository,
            ingredientRepository: _ingredientRepository,
            stepRepository: _stepRepository,
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
