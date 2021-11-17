import 'package:maly_farmar/models/product.dart';

class Farmer {
  final String id;
  final String name;
  final List<Product> products;

  Farmer(
    this.id,
    this.name,
    this.products,
  );
}
