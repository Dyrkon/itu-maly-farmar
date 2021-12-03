import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProvider extends ChangeNotifier {
  UserProfile user;
  FirebaseFirestore _firebaseFirestore;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  UserProvider(
      this.user,
      this._firebaseFirestore,
      );

  Future<void> fetchUserData(String? userId) async {
    var snapshot = await _firebaseFirestore.collection("users").doc(userId).get();

    Map<String, dynamic>? fetchedUser = snapshot.data();
    if (fetchedUser != null)
    {
      user.fullName = fetchedUser["fullName"];
      user.phoneNumber = fetchedUser["phoneNumber"];
      user.location = fetchedUser["location"];
    }
  }

  Future<UserProfile> getUserDataByID(String? userId) async {
    print(user.id);
    var snapshot = await _firebaseFirestore.collection("users").doc(userId).get();


    Map<String, dynamic>? fetchedUser = snapshot.data();
    // print(fetchedUser);

    var newUser = UserProfile(userId, "");
    if (fetchedUser != null)
    {
      newUser.fullName = fetchedUser["fullName"];
      newUser.phoneNumber = fetchedUser["phoneNumber"];
      newUser.location = fetchedUser["location"];
      newUser.email = fetchedUser["email"];
    }

    return newUser;
  }

  Future<void> updateUserData(String? userID, UserProfile profile) async {
    _firebaseFirestore.collection("users").doc(userID).set({

      "email" : profile.email,
      "fullName" : profile.fullName,
      "phoneNumber" : profile.phoneNumber,
      // TODO location
    },SetOptions(merge: true),);

    print(profile.fullName);
  }

  Future uploadImage() async {
    var _picker = ImagePicker();

    var image = await _picker.pickImage(source: ImageSource.gallery);

    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('/IMG_20211129_122822.jpg');

    var url = ref.getDownloadURL();
    print(url);
  }
}
