import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/models/product.dart';
import '../providers/user_provider.dart';

class Orders with ChangeNotifier {
  var orderIndex = 0;
  final FirebaseFirestore _fireStoreInstance;
  final userId;

  Orders(
    this._fireStoreInstance,
    this.userId,
  );

  List<Order> _orders = [
    /*
    Order(
      "0",
      Product,
      Status.pending,
      10,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "1",
      "2",
      Status.pending,
      10,
      DateTime.now(),
      DateTime.now(),
    ),*/
  ];

  List<Order> get activeOrders {
    return [
      ..._orders.where((order) {
        if (order.status == Status.pending ||
            order.status == Status.confirmedBySeller) {
          return true;
        } else {
          return false;
        }
      })
    ];
  }

  Future<void> fetchOrders() async {
    _orders.clear();

    var snapshot = await _fireStoreInstance
        .collection("users")
        .doc(userId)
        .collection("orders")
        .get();

    snapshot.docs.forEach((element) async {
      Map<String, dynamic> order = element.data();
      if (_orders.indexWhere((element) {
            if (element.orderID == order["orderID"]) {
              return true;
            }
            return false;
          }) == -1) {
        _orders.add(
          Order(
            order["orderID"],
            order["productID"],
            Status.values[order["status"]],
            order["orderedAmount"],
            order["orderTime"].toDate(),
            order["pickupTime"].toDate(),
          ),
        );
      }
    });

    notifyListeners();
  }


  Future<void> pushOrder(FirebaseAuth authInstance, Order orderToAdd) async {
    _fireStoreInstance
        .collection("users")
        .doc(authInstance.currentUser?.uid)
        .set({
      "id":
          "TODO", // vymyslet jak to bude s IDs objednavek. Mame treba unikatni IDs useru
      "status": orderToAdd.status,
      "orderedAmount": orderToAdd.orderedAmount,
      "orderTime": orderToAdd.orderTime.toIso8601String(),
      "pickupTime": orderToAdd.pickupTime.toIso8601String()
    }, SetOptions(merge: true) // Objednavku prida nebo updatuje
            ).then((_) {
      // print("succes"); // TODO handle error
    });
  }

  Order orderWithId(String id) {
    return activeOrders.firstWhere((order) {
      if (order.orderID == id) {
        return true;
      } else {
        return false;
      }
    });
  }

  void denyOrder(String id) {
    activeOrders.firstWhere((element) {
      if (element.orderID == id) {
        return true;
      } else {
        return false;
      }
    }).status = Status.denied;

    // print(id);
    updateStatus(id, Status.denied);

    notifyListeners();
  }

  Future<void> updateStatus(String id, Status status) async {
    // print(id);

    _fireStoreInstance
        .collection("users")
        .doc(userId)
        .collection("orders")
        .doc(id)
        .update({"status": status.index});
  }

  void confirmOrder(String id) {
    var order = activeOrders.firstWhere((element) {
      if (element.orderID == id) {
        return true;
      } else {
        return false;
      }
    });

    if (order.status == Status.pending) {
      order.status = Status.confirmedBySeller;
    } else if (order.status == Status.confirmedBySeller) {
      order.status = Status.confirmedByBuyer;
    } else {
      // TODO handle error
    }
    // print(id);
    updateStatus(id, order.status);

    notifyListeners();
  }
}
