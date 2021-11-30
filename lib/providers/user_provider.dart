import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserProfile user;
  FirebaseAuth _firebaseAuth;

  UserProvider(
      this.user,
      this._firebaseAuth,
      );

  // TODO debug
  Future<void> printUserDetails()
  async {
    print(user.email);
    print(user.id);
    // print(user.email);
  }

  Future<void> fetchUserData() async {

  }

  Future<void> updateUserData() async {

  }
}