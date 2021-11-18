import 'package:maly_farmar/models/product.dart';

enum Status {
  confirmedBySeller,
  confirmedByBuyer,
  pending,
  done,
  denied,
}

class Order {
  String id;
  Status status;
  int orderedAmount;
  DateTime orderTime;
  DateTime pickupTime;

  Order(
      this.id,
      this.status,
      this.orderedAmount,
      this.orderTime,
      this.pickupTime,
      );
}