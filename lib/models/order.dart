import 'package:maly_farmar/models/product.dart';

enum Status {
  confirmedBySeller,
  confirmedByBuyer,
  pending,
  done,
  denied,
}

class Order {
  String orderID;
  Status status;
  String productID;
  int orderedAmount;
  DateTime orderTime;
  DateTime pickupTime;

  Order(
      this.orderID,
      this.productID,
      this.status,
      this.orderedAmount,
      this.orderTime,
      this.pickupTime,
      );
}