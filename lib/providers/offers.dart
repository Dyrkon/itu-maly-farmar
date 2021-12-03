import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/models/user.dart';
import '../models/product.dart';

class Offers with ChangeNotifier {
  final FirebaseFirestore _fireStoreInstance;


  Offers(this._fireStoreInstance,);

  List<Offer> _offers = [];

  List<Offer> get offers {
    return [..._offers];
  }

  Future<void> fetchOffers() async {
    var productSnapshot = await _fireStoreInstance.collection("products").get();

    productSnapshot.docs.forEach((element) async {
      Map<String, dynamic> offer = element.data();
      // print(product);
      if (_offers.indexWhere((element) {
        if (element.id == offer["id"]) {
          return true;
        }
        return false;
      }) ==
          -1) {
        var userSnapshot = await _fireStoreInstance.collection("users").doc(
            offer["sellersID"]).get();
        Map<String, dynamic>? user = userSnapshot.data();

        UserProfile fetchedUser = UserProfile(
            offer["sellersID"], user!["email"]);
        fetchedUser.phoneNumber = user["phoneNumber"];
        fetchedUser.fullName = user["fullName"];
        fetchedUser.location = user["location"];

        print(user);


        _offers.add(Offer(
          offer["id"],
          offer["productName"],
          fetchedUser,
          offer["unit"],
          offer["totalAmount"] - offer["reservedAmount"],
        ));
      }
    });

    _offers.forEach((element) {
      print(element.id);
    });
    notifyListeners();
  }
}
