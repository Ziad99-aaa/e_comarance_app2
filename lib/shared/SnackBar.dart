import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 4),
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}
