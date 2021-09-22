import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_clients_by_anduril/bloc/cep_bloc.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/new_client/new_client_screen.dart';

class NewClientsModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CepBloc()),
    Bloc((i) => ClientBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => NewClientScreen();

  static Inject get to => Inject<NewClientsModule>.of();
}