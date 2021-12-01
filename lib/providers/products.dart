import 'dart:io';

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
    Product(
      "1",
      "Vajíčka",
      "Honza Metelesk",
      "ks",
      40,
      20,
      10,
    ),
    Product(
      "2",
      "Hovězí",
      "Honza Metelesk",
      "kg",
      30,
      23,
      9,
    ),
    Product(
      "3",
      "Oves",
      "Honza Metelesk",
      "kg",
      45,
      36,
      23,
    ),
    Product(
      "4",
      "Sýr",
      "Honza Metelesk",
      "ks",
      40,
      20,
      10,
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    var snapshot = await _fireStoreInstance.collection("products").get();

    snapshot.docs.forEach((element) {
      Map<String, dynamic> product = element.data();
      // print(product);
      if (_products.indexWhere((element) {
            if (element.id == product["id"]) {
              return true;
            }
            return false;
          }) ==
          -1) {
        _products.add(Product(
          product["id"],
          product["productName"],
          product["sellersID"],
          product["unit"],
          product["totalAmount"],
          product["totalAmount"] - product["reservedAmount"],
          product["reservedAmount"],
        ));
      }
    });

    /* _products.forEach((element) {
      print(element.id);
    }); */
    notifyListeners();
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
