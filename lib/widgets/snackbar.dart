import 'package:flutter/material.dart';

class Snackbar {
  const Snackbar({
    required this.context,
    required this.text,
    this.isError = false,
  });

  final BuildContext context;
  final String text;
  final bool isError;

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: isError
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
