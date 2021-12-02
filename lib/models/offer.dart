import 'package:maly_farmar/models/user.dart';

class Offer {
  String id;
  String productName;
  UserProfile seller;
  var accessibleAmount;
  var reservedAmount;
  var totalAmount;
  String unit;

  Offer(
      this.id,
      this.productName,
      this.seller,
      this.unit,
      this.accessibleAmount,
      );
}