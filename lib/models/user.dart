import 'package:maly_farmar/models/product.dart';

class UserProfile {
  String? id;
  String fullName = "";
  String phoneNumber = "";
  String? email;
  var location;

  UserProfile(
    this.id,
    this.email,
  );
}
