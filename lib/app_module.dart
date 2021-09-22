import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/app_widget.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/bloc/version_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => UserBloc()),
    Bloc((i) => VersionBloc())
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}