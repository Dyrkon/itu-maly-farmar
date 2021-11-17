import 'package:flutter/material.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:provider/provider.dart';

class Orders with ChangeNotifier {
  var orderIndex = 0;

  final List<Order> _orders = [
    Order(
      "1",
      Status.active,
      DateTime.now(),
      DateTime.now(),

    ),
    Order(
      "2",
      Status.active,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "3",
      Status.active,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "4",
      Status.active,
      DateTime.now(),
      DateTime.now(),
    ),
  ];

  List<Order> get activeOrders {
    return [..._orders.where((order) {
      if (order.status == Status.active) {
        return true;
      } else {
        return false;
      }
    })];
  }

  Order orderWithId(String id) {
    return activeOrders.firstWhere((order) {
      if (order.id == id) {
        return true;
      } else {
        return false;
      }
    });
  }
}
