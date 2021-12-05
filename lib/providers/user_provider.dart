import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProvider extends ChangeNotifier {
  UserProfile user;
  FirebaseFirestore _firebaseFirestore;
  FirebaseAuth authInstance = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;

  String profilePicture = "";

  UserProvider(
    this.user,
    this._firebaseFirestore,
  );

  String get userID {
    var ret = authInstance.currentUser?.uid;
    if (ret != null) {
      return ret;
    } else {
      return "";
    }
  }

  Future<void> fetchUserData(String? userId) async {
    var snapshot = await _firebaseFirestore.collection("users").doc(userId).get();

    Map<String, dynamic>? fetchedUser = snapshot.data();
    if (fetchedUser != null) {
      user.fullName = fetchedUser["fullName"];
      user.phoneNumber = fetchedUser["phoneNumber"];
      user.location = fetchedUser["location"];
      user.email = fetchedUser["email"];
      user.profilePicture = fetchedUser["profilePicture"];
    }
  }

  Future<UserProfile> getUserDataByID(String? userId) async {
    // TODO repeating
    // print(user.id);
    var snapshot = await _firebaseFirestore.collection("users").doc(userId).get();

    Map<String, dynamic>? fetchedUser = snapshot.data();
    // print(fetchedUser);
    // print(fetchedUser!["location"].latitude);
    // print(fetchedUser["location"].longitude);

    var newUser = UserProfile(userId, "");
    if (fetchedUser != null) {
      newUser.profilePicture = await getUserImage(userId);
      newUser.fullName = fetchedUser["fullName"];
      newUser.phoneNumber = fetchedUser["phoneNumber"];
      newUser.location = fetchedUser["location"];
      newUser.email = fetchedUser["email"];
    }

    return newUser;
  }

  Future<void> updateUserData(String? userID, UserProfile profile) async {
    if (userID == null) {
      return;
    }

    _firebaseFirestore.collection("users").doc(userID).set(
      {
        "email": profile.email,
        "fullName": profile.fullName,
        "phoneNumber": profile.phoneNumber,
        "profilePicture": profile.profilePicture,
        "location": profile.location
      },
      SetOptions(merge: true),
    );
  }

  Future<String> getUserImage(String? userID) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("$userID-profile.jpg");

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
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    } catch (e) {
      return true;
    }

    var imageFile = File(image.path);

    try {
      await firebase_storage.FirebaseStorage.instance.ref("${user.id}-profile.jpg").putFile(imageFile);
    } catch (e) {
      return false;
    }
    user.profilePicture = "${user.id}-profile.jpg";
    await updateUserData(user.id, user);

    return true;
  }

  Future<GeoPoint> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return const GeoPoint(90, 180);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return const GeoPoint(90, 180);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return const GeoPoint(90, 180);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var location = await Geolocator.getCurrentPosition();

    return GeoPoint(location.latitude, location.longitude);
  }
}
