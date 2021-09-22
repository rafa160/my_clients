import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/screens/client/client_screen.dart';

class ClientModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => ClientBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ClientScreen();

  static Inject get to => Inject<ClientModule>.of();
}