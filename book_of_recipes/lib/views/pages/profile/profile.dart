import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../widgets/custom_app_bar.dart';
import '../shopping_list/shopping_list_cubit.dart';
import 'profile_cubit.dart';

class Profile extends StatefulWidget {
  final User? user;
  const Profile({required this.user, Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProfileCubit>()
        .init(widget.user?.name ?? 'USERNAME IS NOT PROVIDED');
  }

  Widget _body(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _userImage(),
        _username(),
        _statistics(state),
      ],
    );
  }

  Widget _userImage() {
    final userImage = widget.user?.image;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              96,
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
        ),
        child: userImage == '' || userImage == null
            ? const Center(
                child: Icon(
                  Icons.person,
                  size: 72,
                ),
              )
            : null,
      ),
    );
  }

  Widget _username() {
    final username = widget.user?.name;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${username ?? 'USERNAME IS NOT PROVIDED'}',
      ),
    );
  }

  Widget _statistics(ProfileState state) {
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
          _publishedRecipes(state),
          _divider(),
          _likes(),
        ],
      ),
    );
  }

  Widget _publishedRecipes(ProfileState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.user!.favouriteRecipeIds.length.toString(),
            ),
          ),
          const Text(
            'Saved recipes',
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
    final num = context.read<ShoppingListCubit>().state.shoppingProducts.length;
    return Padding(
      padding: const EdgeInsets.only(
        right: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '$num prod. in',
            ),
          ),
          const Text(
            'Shopping list',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListCubit, ShoppingListState>(
      builder: (_, __) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: customAppBar(title: 'Account', context: context),
              body: _body(state),
            );
          },
        );
      },
    );
  }
}
