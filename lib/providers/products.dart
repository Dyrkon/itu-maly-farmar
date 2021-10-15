import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [

  ];

  List<Product> get getProducts {
    return [..._products];
  }

}
