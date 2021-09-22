import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomColorLinearProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: SizedBox(
          height: 5,
          width: MediaQuery.of(context).size.width,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(background),
          )
        ),
      ),
    );
  }
}