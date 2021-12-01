import 'package:maly_farmar/models/product.dart';

enum Status {
  confirmedBySeller,
  confirmedByBuyer,
  pending,
  done,
  denied,
}

class Order {
  String orderId;
  Status status;
  int orderedAmount;
  DateTime orderTime;
  DateTime pickupTime;

  Order(
      this.orderId,
      this.status,
      this.orderedAmount,
      this.orderTime,
      this.pickupTime,
      );
}