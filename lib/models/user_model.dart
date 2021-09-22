import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String id;
  String name;
  String email;
  bool available;

  UserModel({this.id, this.name, this.email, this.available});

  UserModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    email = snapshot.get('email');
    name = snapshot.get('name');
    available = snapshot.get('available');
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    available = json['available'];
  }

  @override
  String toString() {
    return '\x1B[32mUSER_MODEL\x1B[39m { \n \x1B[33mid\x1B[39m : $id\n \x1B[33mname\x1B[39m : \x1B[31m$name\x1B[0m\n \x1B[33memail\x1B[39m : $email\n \x1B[33mavailable\x1B[39m : $available\n}';
  }

}