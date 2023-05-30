import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/hint_card.dart';
import '../../widgets/published_item_menu.dart';
import '../../widgets/search_field.dart';
import '../../widgets/unit.dart';
import '../unit_managing/unit_managing_page.dart';
import 'published_units_cubit.dart';

class PublishedUnitsPage extends StatelessWidget {
  const PublishedUnitsPage({Key? key}) : super(key: key);

  Widget _body(BuildContext context, PublishedUnitsState state) {
    return Column(
      children: [
        _searchField(context),
        _unitsListView(context, state),
      ],
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
              hintText: 'Search units...',
              onChanged: context.read<PublishedUnitsCubit>().requestChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _unitsListView(BuildContext context, PublishedUnitsState state) {
    if (state.units.isNotEmpty) {
      return Expanded(
        flex: 7,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.units.length,
          itemBuilder: (_, index) => Column(
            children: [
              Unit(
                number: index + 1,
                name: state.units[index].name,
                onLongPress: () => _onLongPress(
                  context: context,
                  index: index,
                  state: state,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      );
    }
    if (state.units.isEmpty) {
      return const Expanded(
        flex: 7,
        child: HintCard(
          text: 'Units are empty. Create a new one to see it here.',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white30,
          ),
          isMaxWidth: true,
        ),
      );
    }
    return const Expanded(
      flex: 7,
      child: HintCard(
        text: 'No units with this request found',
        style: TextStyle(
          fontSize: 32,
          color: Colors.white30,
        ),
        icon: Icon(
          Icons.search,
          color: accentColor,
          size: 96,
        ),
        isMaxWidth: true,
      ),
    );
  }

  void _onLongPress({
    required BuildContext context,
    required int index,
    required PublishedUnitsState state,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PublishedItemMenuBuilder(
        onEditTap: () => _onEditTap(
          context: context,
          index: index,
          state: state,
        ),
        onDeleteTap: () => _onDeleteTap(
          context: context,
          index: index,
          state: state,
        ),
      ),
    );
  }

  void _onEditTap({
    required BuildContext context,
    required int index,
    required PublishedUnitsState state,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UnitManagingPage(
          isCreating: false,
          editingUnit: state.units[index],
        ),
      ),
    );
    Navigator.pop(context);
  }

  void _onDeleteTap({
    required BuildContext context,
    required int index,
    required PublishedUnitsState state,
  }) {
    Navigator.pop(context);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Delete this unit?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              await context.read<PublishedUnitsCubit>().deleteUnit(index);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Deleted successfully!',
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.grey[800],
                  duration: const Duration(seconds: 1),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return CustomFloatingActionButton(
      icon: Icons.add,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const UnitManagingPage(
              isCreating: true,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishedUnitsCubit, PublishedUnitsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(context: context, title: 'Published units'),
          body: _body(context, state),
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }
}
