import 'package:flutter/material.dart';

Widget _galleryOption(BuildContext context, VoidCallback? onTap) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).hintColor,
      borderRadius: BorderRadius.circular(15),
    ),
    margin: const EdgeInsets.symmetric(
      vertical: 8,
    ),
    child: ListTile(
      leading: const Icon(
        Icons.photo,
        color: Colors.black,
      ),
      title: const Text(
        'Gallery',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    ),
  );
}

Widget _cameraOption(BuildContext context, VoidCallback? onTap) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).hintColor,
      borderRadius: BorderRadius.circular(15),
    ),
    child: ListTile(
      leading: const Icon(
        Icons.camera_enhance,
        color: Colors.black,
      ),
      title: const Text(
        'Camera',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    ),
  );
}

Future<String?> showPickerDialog({
  required BuildContext context,
  VoidCallback? onGalleryTap,
  VoidCallback? onCameraTap,
}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Choose option'),
      content: const Text('Where to pick image?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        _galleryOption(context, onGalleryTap),
        _cameraOption(context, onCameraTap),
      ],
    ),
  );
}
