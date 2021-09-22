import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/splash/splash_screen.dart';

class SplashModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => SplashScreen();

  static Inject get to => Inject<SplashModule>.of();
}