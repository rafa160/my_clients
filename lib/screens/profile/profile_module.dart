
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/bloc/version_bloc.dart';
import 'package:my_clients_by_anduril/screens/profile/profile_screen.dart';

class ProfileModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ProfileScreen();

  static Inject get to => Inject<ProfileModule>.of();
}