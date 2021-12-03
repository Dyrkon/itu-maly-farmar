import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maly_farmar/models/product.dart';

class UserProfile {
  String? id;
  String fullName = "";
  String phoneNumber = "";
  String? email;
  String? profilePicture;
  GeoPoint location = GeoPoint(0,0);

  UserProfile(
    this.id,
    this.email,
  );
}
