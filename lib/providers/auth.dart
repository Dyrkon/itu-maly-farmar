import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password) async {
    if (email == "test" && password == "test")
      {
        _expiryDate = DateTime.now().add(const Duration(hours: 1));
        _token = "log";
      }
    else
      {
        _expiryDate = DateTime.now();
        _token = "";
      }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

}
