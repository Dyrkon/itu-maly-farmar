import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String _token = "";
  DateTime _expiryDate = DateTime.now();
  String _userId = "";
  String _userEmail = "";
  String _userPassword = "";

  bool get isAuth {
    return token != "";
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now()) && _token != "") {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  set email (String email) {
    _userEmail = email;
  }

  set password (String password) {
    _userPassword = password;
  }

  Future<void> _authenticate(String email, String password) async {
    print("logged $email $password"); // TODO test
    if (email == "test" && password == "test") {
      _expiryDate = DateTime.now().add(const Duration(hours: 1));
      _token = "log";
    } else {
      _expiryDate = DateTime.now();
      _token = "";
    }
    print("_token is ${_token} and token is ${token}\n"); // TODO test
    notifyListeners();
  }

  Future<void> signup() async {
    return _authenticate(_userEmail, _userPassword);
  }

  Future<void> login() async {
    return _authenticate(_userEmail, _userPassword);
  }

  bool isEmail(String string) {
    if (string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  bool isValid(String val, BuildContext context, controller) {
    if (val.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content:
                  const Text("Zadali jste neplatné údaje. \nZkuste to znovu."),
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
      controller.clear();
      return false;
    }
    return true;
  }
}
