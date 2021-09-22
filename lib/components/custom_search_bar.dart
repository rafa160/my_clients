import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/styles/style.dart';


class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomSearchBar({Key key, this.onTap, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 55,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Align(
                      alignment: Alignment.centerRight, child: Text(text, style: titleForms,)),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
