import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/recipe_card.dart';
import '../../widgets/search_field.dart';
import 'home_cubit.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({required this.user, Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().init(widget.user!.id);
  }

  AppBar _appBar(BuildContext context) {
    final username = widget.user?.name;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.all(
          4,
        ),
        child: _userImage(context),
      ),
      title: Text('Hi, ${username ?? 'USERNAME IS NOT PROVIDED'}'),
    );
  }

  Widget _userImage(BuildContext context) {
    final userImage = widget.user?.image;
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            32,
          ),
        ),
        image: userImage != null && userImage != ''
            ? DecorationImage(
                image: NetworkImage(
                  userImage,
                ),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey,
      ),
      child: userImage == '' || userImage == null
          ? const Center(
              child: Icon(
                Icons.person,
                size: 32,
              ),
            )
          : null,
    );
  }

  Widget _body(BuildContext context, HomeState state) {
    return Column(
      children: [
        _title(),
        _searchField(context),
        _trendingListView(context, state),
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

  Widget _searchField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            SearchField(
              onChanged: context.read<HomeCubit>().requestChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _trendingListView(BuildContext context, HomeState state) {
    if (state.recipes.isEmpty) {
      return const Expanded(
        flex: 7,
        child: HintCard(
          text: 'There are no recipes with such a request.',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white30,
          ),
          isMaxWidth: true,
        ),
      );
    }
    return Expanded(
      flex: 7,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.recipes.length,
        itemBuilder: (_, index) => RecipeCard(
          recipe: state.recipes[index],
          isFavorite: state.isFavoriteRecipe(state.recipes[index].id),
          onHeartPressed: () async {
            await context.read<HomeCubit>().toggleFavorite(
                  widget.user!,
                  state.recipes[index].id,
                );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: _appBar(context),
        body: _body(context, state),
      );
    });
  }
}
