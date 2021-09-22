import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/components/custom_toast_message.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ToastUtilsFail {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message) {

    return OverlayEntry(
        builder: (context) => Positioned(
          bottom: 50.0,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding:
              EdgeInsets.only(left: 10, right: 10,
                  top: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xffe53e3f),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.times,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          message,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: buttonColors
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}

class ToastUtilsSuccess {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message) {

    return OverlayEntry(
        builder: (context) => Positioned(
          bottom: 50.0,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.only(left: 10, right: 10,
                  top: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        message,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: alertDialogTitle
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}

class ToastUtilsTest {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context,
      String message, String messageDois) {

    if (toastTimer == null || toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, messageDois);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(minutes: 5), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
          _overlayEntry = null;
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message, String messageDois) {

    return OverlayEntry(
        builder: (context) => Positioned(
          bottom: 50.0,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent[100],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  message,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: TextStyle(color: Colors.deepPurple[100])
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              _overlayEntry.remove();
                              _overlayEntry = null;
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.times,
                                color: Colors.deepPurple[100],
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                messageDois,
                                textAlign: TextAlign.start,
                                softWrap: true,
                                style: alertDialogTitle
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}