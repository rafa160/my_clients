import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/date_bloc.dart';
import 'package:my_clients_by_anduril/screens/home/home_screen.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => DateBloc()),
    Bloc((i) => ClientBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomeScreen();

  static Inject get to => Inject<HomeModule>.of();
}