import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/models/user.dart';

class Offers with ChangeNotifier {
  final FirebaseFirestore _fireStoreInstance;
  int currentOffer = 0;

  Offers(
    this._fireStoreInstance,
  );

  List<Offer> _offers = [];

  List<Offer> get offers {
    return [..._offers];
  }

  Future<void> fetchOffers() async {
    var productSnapshot = await _fireStoreInstance
        .collection("products")
        .where("offered", isEqualTo: true)
        .get();

    _offers.clear();

    for (var element in productSnapshot.docs) {
      Map<String, dynamic> offer = element.data();
      // print(product);
      if (_offers.indexWhere((element) {
            if (element.id == offer["id"]) {
              return true;
            }
            return false;
          }) ==
          -1) {
        var userSnapshot = await _fireStoreInstance
            .collection("users")
            .doc(offer["sellersID"])
            .get();
        Map<String, dynamic>? user = userSnapshot.data();

        if (user == null) {
          return;
        }

        UserProfile fetchedUser =
            UserProfile(offer["sellersID"], user["email"]);
        fetchedUser.phoneNumber = user["phoneNumber"];
        fetchedUser.fullName = user["fullName"];
        fetchedUser.location = user["location"];

        _offers.add(Offer(
            id: offer["id"],
            productName: offer["productName"],
            seller: fetchedUser,
            unit: offer["unit"],
            imagePath: offer["imagePath"],
            description: offer["description"],
            accessibleAmount: offer["totalAmount"] - offer["reservedAmount"],
            price: offer["price"]));
      }
    }

    _offers.forEach((element) {
      print(element.id);
    });
    notifyListeners();
  }
}
