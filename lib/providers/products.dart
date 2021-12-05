import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//autor: Adam Jetmar
//
//
//
class Products with ChangeNotifier {
  final FirebaseFirestore _fireStoreInstance;
  final _userId;

  Products(
    this._fireStoreInstance,
    this._userId,
  );

  List<Product> _products = [];

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
            if (element.id == product["id"]) {
              return true;
            }
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
    notifyListeners();
  }

  Future<Product> getProduct(productID) async {
    var snapshot = await _fireStoreInstance.collection("products").where("id", isEqualTo: productID).get();
    Product newProduct = Product("", "", "", "", -1, -1, -1, -1, "", false);

    for (var element in snapshot.docs) {
      if (element.exists) {
        Map<String, dynamic> product = element.data();
        newProduct.id = product["id"];
        newProduct.unit = product["unit"];
        newProduct.price = product["price"];
        newProduct.accessibleAmount = product["totalAmount"] - product["reservedAmount"];
        newProduct.description = product["description"];
        newProduct.productName = product["productName"];
        newProduct.imagePath = product["imagePath"];
        newProduct.totalAmount = product["totalAmount"];
        newProduct.reservedAmount = product["reservedAmount"];
        newProduct.offered = true;
        newProduct.sellersID = product["sellersID"];
        return newProduct;
      }
    }

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

  Future<bool> updateProduct(Product product) async {
    print(product.id);
    print(product.productName);
    print(product.totalAmount);
    print(product.reservedAmount);

    var products = await _fireStoreInstance.collection('products').doc(product.id).update({
      'accessibleAmount': product.totalAmount - product.reservedAmount,
      'reservedAmount': product.reservedAmount,
      'totalAmount': product.totalAmount,
      'offered': product.offered == true ? (((product.totalAmount - product.reservedAmount) > 0) ? true : false) : false,
    });

    return true;
  }

  Future<String> uploadProductPhoto(String productID) async {
    var _picker = ImagePicker();
    var image;

    try {
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    } catch (e) {
      return "";
    }

    var imageFile = File(image.path);

    try {
      await firebase_storage.FirebaseStorage.instance.ref("p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg").putFile(imageFile);
    } catch (e) {
      return "";
    }
    return "p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg";
  }

  Future<String> getProductImage(String? productID) async {
    if (productID == null) {
      return "";
    }

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("p${productID.replaceAll(" ", "").replaceAll(':', "D")}-product-image.jpg");

    var url;

    try {
      url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1";
    }
  }
}
