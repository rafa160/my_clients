
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/screens/login/login_screen.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [

  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginScreen();

  static Inject get to => Inject<LoginModule>.of();
}