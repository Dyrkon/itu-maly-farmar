import 'package:maly_farmar/models/product.dart';

enum Status {
  active,
  pending,
  done,
}

class Order {
  String id;
  Status status;
  DateTime orderTime;
  DateTime pickupTime;

  Order(
      this.id,
      this.status,
      this.orderTime,
      this.pickupTime,
      );
}