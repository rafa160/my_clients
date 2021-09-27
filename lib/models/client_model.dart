import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';

enum ClientStatus {
  prospect,
  client
}

class ClientModel {

  String id;
  String name;
  String company;
  String document;
  String phone;
  String whatsApp;
  String email;
  AddressModel addressModel;
  String number;
  DateTime createdTime;
  DateTime nextVisit;
  String employeeId;
  ClientStatus status;
  String observations;
  String budget;
  String companyKey;
  int day;
  int month;

  ClientModel(
      {this.id,
      this.name,
      this.company,
      this.document,
      this.phone,
      this.addressModel,
      this.number,
      this.createdTime,
      this.employeeId,
      this.status,
      this.nextVisit,
      this.observations,
      this.companyKey,
      this.whatsApp,
      this.email,
      this.day,
      this.month, this.budget});

  ClientModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
    company = snapshot.get('company');
    document = snapshot.get('document');
    phone = snapshot.get('phone');
    number = snapshot.get('number');
    addressModel = AddressModel.fromMap(snapshot.get('address'));
    createdTime = snapshot.get('date') != null
        ? DateTime.fromMillisecondsSinceEpoch(
        snapshot.get('date').millisecondsSinceEpoch)
        : null;
    nextVisit = snapshot.get('next_visit') != null
        ? DateTime.fromMillisecondsSinceEpoch(
        snapshot.get('next_visit').millisecondsSinceEpoch)
        : null;
    employeeId = snapshot.get('employee_id');
    status = ClientStatus.values[snapshot.get('status') as int];
    observations = snapshot.get('observations');
    budget = snapshot.get('budget') != null ? snapshot.get('budget') : null;
    companyKey = snapshot.get('company_key');
    email = snapshot.get('email');
    whatsApp = snapshot.get('whats_app');
    month = snapshot.get('month');
    day = snapshot.get('day');
  }

  String get statusText => getStatusText(status);

  static String getStatusText(ClientStatus status) {
    switch (status) {
      case ClientStatus.prospect:
        return 'Prospecto';
      case ClientStatus.client:
        return 'Cliente';
      default:
        return 'Prospecto';
    }
  }
}