import 'package:flutter/material.dart';

class ShowSnackBar {
  ShowSnackBar(BuildContext context, String text, int time, Color? color) {
    SnackBar snackBar = SnackBar(
      content: Text(text,
          style: const TextStyle(
              fontFamily: 'Pokemon', letterSpacing: 1.8, fontSize: 12)),
      duration: Duration(seconds: time),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
