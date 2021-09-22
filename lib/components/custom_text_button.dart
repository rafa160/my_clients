import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/styles/style.dart';



class CustomTextButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const CustomTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: typeText,
      ),
    );
  }
}
