import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class SearchDialog extends StatelessWidget {

  final String initialText;

  const SearchDialog( this.initialText);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 4,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              style: titleForms,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                    icon: FaIcon(FontAwesomeIcons.chevronLeft, color: Color(0xff4F46E5)),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
