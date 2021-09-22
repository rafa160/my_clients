

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/screens/login/login_module.dart';
import 'package:my_clients_by_anduril/splash/splash_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    return GetMaterialApp(
      title: 'My Clients',
      theme: ThemeData(fontFamily: 'Nunito', primaryColor: background),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: SplashModule(),
    );
  }
}


