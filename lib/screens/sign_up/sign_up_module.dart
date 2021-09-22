import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/screens/sign_up/sign_up_screen.dart';

class SignUpModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SignUpScreen();

  static Inject get to => Inject<SignUpModule>.of();
}