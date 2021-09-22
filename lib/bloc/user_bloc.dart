import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/components/custom_animation_toast.dart';
import 'package:my_clients_by_anduril/helpers/firebase_erros.dart';
import 'package:my_clients_by_anduril/screens/login/login_module.dart';
import 'package:my_clients_by_anduril/screens/main/main_module.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserBloc extends BlocBase {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  UserCredential userCredential;
  UserModel user = new UserModel();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _user$ = BehaviorSubject<UserModel>.seeded(null);

  StreamController<bool> _streamController = StreamController<bool>.broadcast();
  Stream get loadingStream => _streamController.stream;
  Sink get loadingSink => _streamController.sink;

  bool _available = true;
  bool get available => _available;
  set available(value) {
    _available = value;
  }

  String _name = '';
  String get name => _name;
  set name(value) {
    _name = value;
  }

  Future<UserCredential> signIn(
      String email, String password, BuildContext context) async {
    _streamController.add(true);
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      user = await getUserModel(id: userCredential.user.uid);
      _name = user.name;

      await _saveUserData();
      await isLogged();
      if(user.available == true) {
        _streamController.add(false);
        Get.offAll(() => MainModule());
      } else {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, 'error inesperado!');
      }

    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, 'error');
      }
    }
  }

  Future<UserModel> getUserModel({String id}) async {
    try {
      if(id != null) {
        DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
        user = UserModel.fromDocument(documentSnapshot);
        print(user.toString());
        return user;
      } else {
        user = null;
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future _saveUserData() async {

    if (userCredential == null) {
      signOut();
    }

    Map<String, dynamic> userData = {
      'id': userCredential.user.uid,
      "email": userCredential.user.email,
      "name": _name,
      "available": _available,
    };

    DocumentSnapshot userModel = await getUser(userId: userCredential.user.uid);
    if (userModel == null) {
      await _fireStore
          .collection('users')
          .doc(userCredential.user.uid)
          .set(userData);
    }
    await _saveUserLocally(userData);
    user = UserModel.fromJson(userData);
  }

  Future<DocumentSnapshot> getUser({String userId}) async {
    String id;
    if (userId == null) {
      var loggedUser = await loggedUserAsync();
      if (loggedUser == null) return null;
      id = loggedUser.id;
    } else {
      id = userId;
    }
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();

    return documentSnapshot.exists ? documentSnapshot : null;
  }

  Future<UserModel> loggedUserAsync() async {
    return await get<UserModel>("users",
        construct: (v) => UserModel.fromJson(v));
  }

  Future get<S>(String key, {S Function(Map) construct}) async {
    try {
      SharedPreferences share = await _prefs;
      String value = share.getString(key);
      Map<String, dynamic> json = jsonDecode(value);
      if (construct == null) {
        return json;
      } else {
        return construct(json);
      }
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    user = null;
    _streamController.add(null);
    _deleteUserLocally();
  }

  void _deleteUserLocally() async {
    var preference = await _prefs;
    preference.clear();
  }

  Future<bool> isLogged() async {
    var preference = await _prefs;
    return preference.get('users') != null;
  }

  Future<bool> _saveUserLocally(Map<String, dynamic> json) async {
    try {
      SharedPreferences share = await _prefs;
      share.setString('users', jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserCredential> signUp({String email, String password, name, String number,BuildContext context, String phone}) async {
    _streamController.add(true);
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      _name = name;
      _available = true;
      await _saveUserData();
      user = await getUserModel(id: userCredential.user.uid);
      await isLogged();
      _streamController.add(false);
      Get.offAll(() => MainModule());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        _streamController.add(false);
        ToastUtilsFail.showCustomToast(context, error);
      }
    }
    return userCredential;
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      _streamController.add(true);
      await _auth.sendPasswordResetEmail(email: email);
      ToastUtilsSuccess.showCustomToast(context, 'Solicitação enviada para o e-mail $email');
      _streamController.add(false);
      await Get.offAll(() => LoginModule());
    } on FirebaseAuthException catch (e) {
      _streamController.add(false);
      var error = getErrorString(e.code);
      if (e.code != null) {
        ToastUtilsFail.showCustomToast(context, error);
      } else {
        ToastUtilsFail.showCustomToast(context, error);
      }
    }

  }

}