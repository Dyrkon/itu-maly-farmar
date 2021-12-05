import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final FirebaseAuth _firebaseAuth;
  String? errorMsg;

  var _firstTimeLogin = true;

  Auth(
    this._firebaseAuth,
  );

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        errorMsg = e.message;
      }
      return "Error";
    }
  }

//registrace
  Future<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        errorMsg = e.message;
      }
      return "Error";
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  FirebaseAuth get firebaseInstance => _firebaseAuth;

  void invalidCredentialsAlert(value, context, nameController, passwordController) {
    if (value == "Error") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text("Zadali jste neplatné údaje. \nZkuste to znovu."),
              title: const Text("Neplatné přihlašovací údaje!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          });
      passwordController.clear();
      nameController.clear();
    }
  }

  Future<void> FirstTimeLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') ?? true;
    if (firstTime) {
      await prefs.setBool('first_time', false);
      _firstTimeLogin = true;
    }
    _firstTimeLogin = false;
  }

  FirebaseFirestore get getUser {
    return FirebaseFirestore.instance;
  }

  bool get firstTime {
    return _firstTimeLogin;
  }
}
