import 'package:flutter/material.dart';

Future<String?> thShowAlert(
  BuildContext context, {
  required String content,
  required VoidCallback onConfirm,
  String routeName = '/th-dialog-route',
  String acceptedString = 'Yes',
  String rejectedString = 'No',
}) {
  return showDialog<String>(
    context: context,
    routeSettings: RouteSettings(name: routeName),
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Attention!'),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(rejectedString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(acceptedString),
        ),
      ],
    ),
  );
}
