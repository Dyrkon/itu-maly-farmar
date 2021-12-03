import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  final FirebaseFirestore _fireStoreInstance;
  final _userId;

  Products(
    this._fireStoreInstance,
    this._userId,
  );

  List<Product> _products = [
    Product("1", "Vajíčka", "Honza Metelesk", "ks", 40, 20, 20, 5,
        "Vajíčka snášejí slepičky v doprčicích hehehe :)))"),
    Product("2", "Hovězí", "Honza Metelesk", "kg", 30, 20, 10, 250,
        "prostě z kravičky no víšco hehehe :))))"),
    Product("3", "Oves", "Honza Metelesk", "kg", 45, 25, 20, 200,
        "ovsík pro tvýho koníka víšco hehehe :)))"),
    Product("4", "Sýr", "Honza Metelesk", "ks", 40, 20, 20, 40,
        "kvalitní sýreček hehehe :))))"),
  ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    _products.clear();

    var snapshot = await _fireStoreInstance
        .collection("products")
        .where("sellersID", isEqualTo: _userId)
        .get();

    snapshot.docs.forEach((element) {
      Map<String, dynamic> product = element.data();
      if (_products.indexWhere((element) {
            if (element.id == product["id"]) {
              return true;
            }
            return false;
          }) == -1) {
        _products.add(Product(
          product["id"],
          product["productName"],
          product["sellersID"],
          product["unit"],
          product["totalAmount"],
          product["totalAmount"] - product["reservedAmount"],
          product["reservedAmount"],
          product["price"],
          product["description"],
        ));
      }
    });

    /* _products.forEach((element) {
      print(element.id);
    }); */
    notifyListeners();
  }

  Future<Product> getProduct(productID) async {
    var productSnapshot = await _fireStoreInstance
        .collection("products")
        .doc(productID)
        .get();
    Map<String, dynamic>? product = productSnapshot.data();

    notifyListeners();
    return Product(
        product!["id"],
        product["productName"],
        product["sellersID"],
        product["unit"],
        product["totalAmount"],
        product["totalAmount"] - product["reservedAmount"],
        product["reservedAmount"],
        product["price"],
        product["description"]);
  }

  Product productWithId(String id) {
    return products.firstWhere((product) {
      if (product.id == id) {
        return true;
      } else {
        return false;
      }
    });
  }
}
