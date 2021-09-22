import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  CustomAppBar({Key key, this.title}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final String title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomAnimatedContainer(
          milliseconds: 1000,
          horizontalOffset: 50,
          position: 1,
          widget: AppBar(
            elevation: 0,
            backgroundColor: background,
            centerTitle: true,
            title: Text(
              widget.title,
              style: buttonColors,
              softWrap: true,
              // overflow: TextOverflow.ellipsis,
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}