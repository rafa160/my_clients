
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

import 'custom_text_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget widget;
  final VoidCallback yes;

  const CustomAlertDialog({Key key, this.title, this.content, this.yes, this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        title,
        style: buttonColorBlack,
      ),
      content: Text(
        content,
        style: tittleCardText,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              text: 'não',
              onPressed: () {
                Get.back();
              },
            ),
            CustomTextButton(
              text: 'sim',
              onPressed: yes
            ),
          ],
        )
      ],
    );
  }
}
