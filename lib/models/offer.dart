import 'package:maly_farmar/models/user.dart';

//autor: Ondřej Kříž
//
//
//
class Offer {
  int distance = -1;
  String id;
  String productName;
  UserProfile seller;
  var accessibleAmount;
  var price;
  String description;
  String imagePath;
  String unit;

  Offer({
    required this.id,
    required this.productName,
    required this.seller,
    required this.unit,
    required this.imagePath,
    required this.description,
    required this.accessibleAmount,
    required this.price,
  });
}
