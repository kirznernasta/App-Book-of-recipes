import 'package:flutter/material.dart';

class PublishedItemMenuBuilder extends StatelessWidget {
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  const PublishedItemMenuBuilder({
    this.onEditTap,
    this.onDeleteTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onEditTap,
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: const Text(
            'edit',
          ),
        ),
        ListTile(
          onTap: onDeleteTap,
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: const Text(
            'delete',
          ),
        ),
      ],
    );
  }
}
