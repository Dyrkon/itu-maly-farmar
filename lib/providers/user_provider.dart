import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserProfile user;
  FirebaseFirestore _firebaseFirestore;

  UserProvider(
      this.user,
      this._firebaseFirestore,
      );

  Future<void> fetchUserData() async {
    var snapshot = _firebaseFirestore.collection("users").doc(user.id).snapshots();

    await snapshot.first.then((value) {
      Map<String, dynamic>? fetchedUser = value.data();
      if (fetchedUser != null)
      {
        user.fullName = fetchedUser["fullName"];
        user.phoneNumber = fetchedUser["phoneNumber"];
        user.location = fetchedUser["location"];
      }
    });
  }

  Future<void> updateUserData() async {

  }
}