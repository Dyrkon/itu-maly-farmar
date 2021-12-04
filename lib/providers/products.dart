import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Products with ChangeNotifier {
  final FirebaseFirestore _fireStoreInstance;
  final _userId;

  Products(
    this._fireStoreInstance,
    this._userId,
  );

  List<Product> _products = [
    /*
    Product("1", "Vajíčka", "Honza Metelesk", "ks", 40, 20, 20, 5,
        "Vajíčka snášejí slepičky v doprčicích hehehe :)))"),
    Product("2", "Hovězí", "Honza Metelesk", "kg", 30, 20, 10, 250,
        "prostě z kravičky no víšco hehehe :))))"),
    Product("3", "Oves", "Honza Metelesk", "kg", 45, 25, 20, 200,
        "ovsík pro tvýho koníka víšco hehehe :)))"),
    Product("4", "Sýr", "Honza Metelesk", "ks", 40, 20, 20, 40,
        "kvalitní sýreček hehehe :))))"), */
  ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    _products.clear();
    // print("ID "+_userId);

    var snapshot = await _fireStoreInstance.collection("products").where("sellersID", isEqualTo: _userId).get();

    for (var element in snapshot.docs) {
      Map<String, dynamic> product = element.data();
      if (_products.indexWhere((element) {
            // print("ID "+element.id);
            if (element.id == product["id"]) {
              // print("ID2 "+product["id"]);
              // print(true);
              return true;
            }
            // print("ID3 "+product["id"]);
            return false;
          }) ==
          -1) {
        var newProduct = Product(
          product["id"],
          product["productName"],
          product["sellersID"],
          product["unit"],
          product["totalAmount"],
          product["totalAmount"] - product["reservedAmount"],
          product["reservedAmount"],
          product["price"],
          product["description"],
          product["offered"],
        );
        newProduct.imagePath = product["imagePath"];
        _products.add(newProduct);
      }
    }
    // sleep(Duration(seconds: 2));
    // _products.forEach((element) {print("Actual "+element.productName);});
    notifyListeners();
  }

  Future<Product?> getProduct(productID) async {
    var productSnapshot = await _fireStoreInstance.collection("products").doc(productID).get();

    print(productID);

    Map<String, dynamic>? product = productSnapshot.data();

    if (product == null) {
      return null;
    }

    Product newProduct = Product(
      product["id"],
      product["productName"],
      product["sellersID"],
      product["unit"],
      product["totalAmount"],
      product["totalAmount"] - product["reservedAmount"],
      product["reservedAmount"],
      product["price"],
      product["description"],
      product["offered"],
    );

    newProduct.imagePath = product["imagePath"];

    notifyListeners();
    return newProduct;
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

  Future<bool> pushProduct(Product product) async {
    // print("In provider" + product.imagePath);
    bool tmp = false;
    var products = await _fireStoreInstance
        .collection('products')
        .doc(product.id)
        .set({
          'id': product.id,
          'productName': product.productName,
          'sellersID': _userId,
          'unit': product.unit,
          'totalAmount': product.totalAmount,
          'reservedAmount': 0,
          'price': product.price,
          'description': product.description,
          'imagePath': product.imagePath,
          'offered': product.offered,
        })
        .then((value) => tmp = true)
        .catchError((error) => tmp = false);
    return tmp;
  }

  Future<bool> updateProduct(Product product, int newAmount, bool toOffer) async {
    var products = await _fireStoreInstance.collection('products').doc(product.id).update({'totalAmount': newAmount, 'offered': toOffer});
    return true;
  }

  Future<String> uploadProductPhoto(String productID) async {
    var _picker = ImagePicker();
    var image;

    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      return "";
    }

    var imageFile = File(image.path);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg")
          .putFile(imageFile);
    } catch (e) {
      return "";
    }
    // print("p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg");
    return "p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg";
  }

  Future<String> getProductImage(String? productID) async {
    if (productID == null) {
      return "";
    }

    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref("p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg");

    var url;

    try {
      url = await ref.getDownloadURL();
      // print("URLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
      // print(url);
      return url;
    } catch (e) {
      //print(e);
      return "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1";
    }
  }
}
