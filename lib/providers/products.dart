import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      "1",
      "Vajíčka",
      "ks",
      40,
      20,
      10,
    ),
    Product(
      "2",
      "Hovězí",
      "kg",
      30,
      23,
      9,
    ),
    Product(
      "3",
      "Oves",
      "kg",
      45,
      36,
      23,
    ),
    Product(
      "4",
      "Sýr",
      "ks",
      40,
      20,
      10,
    ),
  ];

  List<Product> get products {
    return [..._products];
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
