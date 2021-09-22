import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/prospect_client_details/prospect_client_details_page.dart';

class ProspectClientDetailsModule extends ModuleWidget {

  final ClientModel clientModel;

  ProspectClientDetailsModule(this.clientModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => ClientBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ProspectClientDetailsScreen(clientModel: clientModel,);

  static Inject get to => Inject<ProspectClientDetailsModule>.of();
}