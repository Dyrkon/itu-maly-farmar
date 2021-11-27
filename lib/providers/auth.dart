import 'dart:convert';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth {
  final FirebaseAuth _firebaseAuth;
  String? errorMsg;

  Auth(
    this._firebaseAuth,
  );

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> singIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        errorMsg = e.message;
      }
      return "Error";
    }
  }

  Future<String> singUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        errorMsg = e.message;
      }
      return "Error";
    }
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  FirebaseAuth get firebaseInstance => _firebaseAuth;

  void invalidCredentialsAlert(value, context, nameController, passwordController) {
    if (value == "Error") {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(
                  "Zadali jste neplatné údaje. \nZkuste to znovu."),
              title: const Text(
                  "Neplatné přihlašovací údaje!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          }
      );
      passwordController.clear();
      nameController.clear();
    }
  }
}
