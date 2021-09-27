import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/pdf_bloc.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/client/client_details/client_details_screen.dart';

class ClientDetailsModule extends ModuleWidget {

  final ClientModel clientModel;

  ClientDetailsModule(this.clientModel);

  @override
  List<Bloc> get blocs => [
    Bloc((i) => PdfBloc()),
    Bloc((i) => ClientBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ClientDetailsScreen(clientModel: clientModel);

  static Inject get to => Inject<ClientDetailsModule>.of();
}