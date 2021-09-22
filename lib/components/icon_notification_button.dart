import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class IconNotification extends StatelessWidget {
  final FaIcon icon;
  final VoidCallback onTap;
  final String notification;

  const IconNotification({
    Key key,
    this.onTap,
    @required this.icon,
    this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
              ],
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 18,
                height: 22,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent[100]),
                alignment: Alignment.center,
                child: Text(notification, style: actionButton,),
              ),
            )
          ],
        ),
      ),
    );
  }
}