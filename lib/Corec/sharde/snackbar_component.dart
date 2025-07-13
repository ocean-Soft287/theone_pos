import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {int? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration ?? 3),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
