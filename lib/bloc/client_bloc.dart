import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_clients_by_anduril/components/custom_animation_toast.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/main/main_module.dart';
import 'package:rxdart/subjects.dart';

class ClientBloc extends BlocBase {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  ///
  /// Method to create a register
  ///

  Future<void> registerClient(
      {String name, String company,
      String document, String phone,
      String number, AddressModel addressModel, String whatsApp, String email,
      String employeeId, BuildContext context}) async {

    _streamController.add(true);
    try {
      DateTime _now = DateTime.now();
      Map<String, dynamic> clientData = {
        "name": name,
        "company": company,
        "document": document,
        "phone": phone,
        "address": addressModel.toMap(),
        "date": _now,
        "employee_id": employeeId,
        "number": number,
        "status": 0,
        "whats_app": whatsApp,
        "email": email,
        "day": null,
        "month": null,
        "observations": null,
        "next_visit": null,
        "company_key": null
      };
      await _fireStore.collection('clients').add(clientData);
      _streamController.add(false);

      Get.offAll(() => MainModule());
    } catch (e) {
      _streamController.add(false);
      ToastUtilsFail.showCustomToast(context, 'erro ao prospectar cliente');
    }
    ToastUtilsSuccess.showCustomToast(context, 'Cliente Cadastrado');

  }

   ///
   /// Find prospect by EmployeeId status 0
   ///

  final _prospectClientsByEmployeeId = BehaviorSubject<List<ClientModel>>();
  Stream<List<ClientModel>> get listProspectClientsByEmployeeId => _prospectClientsByEmployeeId.stream;
  Sink<List<ClientModel>> get sinkProspectClientsByEmployeeId => _prospectClientsByEmployeeId.sink;

  final _streamProspectLength = BehaviorSubject<int>();
  Stream<int> get lengthProspect => _streamProspectLength.stream;
  Sink<int> get  sinkLengthProspect => _streamProspectLength.sink;

  List<ClientModel> prospectClientList = [];

  String _searchProspect = '';
  String get searchProspect => _searchProspect;
  set searchProspect(value) {
    _searchProspect = value;
  }

  Future<List<ClientModel>> getProspectsListByEmployeeId({String employeeId}) async {
    prospectClientList.clear();
    final QuerySnapshot snapshot = await _fireStore.collection('clients').where('status', isEqualTo: 0)
        .where('employee_id', isEqualTo: employeeId)
        .orderBy('date', descending: false).get();
    prospectClientList = snapshot.docs.map((e) => ClientModel.fromDocument(e)).toList();
    _prospectClientsByEmployeeId.sink.add(prospectClientList);
    _streamProspectLength.sink.add(prospectClientList.length);
    return prospectClientList;
  }

  List<ClientModel> get filteredList {
    final List<ClientModel> filtered = [];
    if(searchProspect.isEmpty) {
      filtered.addAll(prospectClientList);
    } else {
      filtered.addAll(prospectClientList.where((element) => element.company.toLowerCase().contains(searchProspect.toLowerCase())));
    }
    prospectClientList.clear();
    prospectClientList.addAll(filtered);
    _prospectClientsByEmployeeId.sink.add(filtered);
    return filtered;
  }


      ///
     /// update the client status, need a observation
    ///  the company_key that gives to you and a new date to visit,
   ///  When u finish this action the status will change for 1(client).
   ///

  Future<void> updateClientStatus({String companyKey, String observation, DateTime dateTime, BuildContext context, String id}) async {
    _streamController.add(true);
    try {
      Map<String, dynamic> clientData = {
        "status": 1,
        "observations": observation,
        "next_visit": dateTime,
        "company_key": companyKey,
        "day": dateTime.day,
        "month":dateTime.month
      };
      await _fireStore.collection('clients').doc(id).update(clientData);
      _streamController.add(false);
      Get.offAll(() => MainModule());
    } catch (e) {
      _streamController.add(false);
      ToastUtilsFail.showCustomToast(context, 'erro ao prospectar cliente');
    }
    ToastUtilsSuccess.showCustomToast(context, 'cliente atualizados com sucesso!');
  }

  ///
  /// Find prospect by EmployeeId status 1
  ///

  Stream<List<ClientModel>> clientsByEmployeeId;
  List<ClientModel> clientListWithKey = [];

  final _streamClienttLength = BehaviorSubject<int>();
  Stream<int> get lengthClient => _streamClienttLength.stream;
  Sink<int> get  sinkLengthClient => _streamClienttLength.sink;

  String _searchClientKey = '';
  String get searchClientKey => _searchClientKey;
  set searchClientKey(value) {
    _searchClientKey = value;
  }

  Future<List<ClientModel>> getClientsWithKeyListByEmployeeId({String employeeId}) async {
    clientListWithKey.clear();
    final QuerySnapshot snapshot = await _fireStore.collection('clients').where('status', isEqualTo: 1)
        .where('employee_id', isEqualTo: employeeId)
        .orderBy('date', descending: false).get();
    clientListWithKey = snapshot.docs.map((e) => ClientModel.fromDocument(e)).toList();
    _streamClienttLength.sink.add(clientListWithKey.length);
    return clientListWithKey;
  }

  List<ClientModel> get filteredClientWithKeyList {
    final List<ClientModel> filtered = [];
    if(searchClientKey.isEmpty) {
      filtered.addAll(clientListWithKey);
    } else {
      filtered.addAll(clientListWithKey.where((element) => element.company.toLowerCase().contains(searchClientKey.toLowerCase())));
    }
    clientListWithKey.clear();
    clientListWithKey.addAll(filtered);
    _streamClienttLength.sink.add(filtered.length);
    return filtered;
  }

  ///
  /// Delete prospect client
  ///

  Future<void> deleteProspect(String id, BuildContext context) async {
    await _fireStore.collection('clients').doc(id).delete();
    ToastUtilsSuccess.showCustomToast(context, 'deletado com sucesso!');
  }

  ///
  /// update visit date
  ///

  Future<void> updateDate({BuildContext context, DateTime dateTime, String id}) async {
    _streamController.add(true);
    Map<String, dynamic> data = {
      "next_visit": dateTime,
      "day": dateTime.day,
      "month":dateTime.month
    };
    _fireStore.collection('clients').doc(id).update(data);
    _streamController.add(false);
    Get.offAll(() => MainModule());
    ToastUtilsSuccess.showCustomToast(context, 'Data da visita atualizada.');
  }

  ///
  /// get list for today's clients and actual month visits
  ///

  List<ClientModel> todaysClientsList = [];
  List<ClientModel> monthVisitsClientsList = [];
  DateTime _today = DateTime.now();
  Future<List<ClientModel>> getTodaysClientList({String id}) async {
    final QuerySnapshot snapshot = await _fireStore
        .collection('clients')
        .where('employee_id', isEqualTo: id)
        .where('day', isEqualTo: _today.day)
        .where('status', isEqualTo: 1)
        .orderBy('next_visit', descending: false)
        .get();
    todaysClientsList = snapshot.docs.map((e) => ClientModel.fromDocument(e)).toList();
    return todaysClientsList;
  }

  Future<List<ClientModel>> getMonthVisitsClientList({String id}) async {
    final QuerySnapshot snapshot = await _fireStore
        .collection('clients')
        .where('employee_id', isEqualTo: id)
        .where('month', isEqualTo: _today.month)
        .where('status', isEqualTo: 1)
        .orderBy('next_visit', descending: false)
        .get();
    monthVisitsClientsList = snapshot.docs.map((e) => ClientModel.fromDocument(e)).toList();
    return monthVisitsClientsList;
  }

  @override
  void dispose() {
    _prospectClientsByEmployeeId.close();
    super.dispose();
  }
}