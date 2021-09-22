import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/screens/reset_password/reset_password_screen.dart';


class ResetPasswordModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ResetPasswordScreen();

  static Inject get to => Inject<ResetPasswordModule>.of();
}