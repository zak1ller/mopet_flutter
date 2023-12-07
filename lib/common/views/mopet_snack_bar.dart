import 'package:flutter/material.dart';

class MopetSnackBar {
  static void show(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
      ),
    );
  }
}
