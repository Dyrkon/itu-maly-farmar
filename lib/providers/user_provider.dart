import 'dart:io';

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

  String profilePicture = "";

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
      newUser.profilePicture = await getUserImage(userId);
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
      "profilePicture" : profile.profilePicture,
      // TODO location
    },SetOptions(merge: true),);
  }

  Future<String> getUserImage(String? userID) async {

    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref("$userID-profile.jpg");

    try {
      profilePicture = await ref.getDownloadURL();
    } catch (e) {
      return "";
    }
    return profilePicture;
  }

  Future<bool> uploadUserPhoto() async {
    var _picker = ImagePicker();
    var image;

    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      return true;
    }

    var imageFile = File(image.path);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("${user.id}-profile.jpg")
          .putFile(imageFile);
    }catch (e) {
      return false;
    }
    user.profilePicture = "${user.id}-profile.jpg";
    await updateUserData(user.id, user);

    return true;
  }
}
