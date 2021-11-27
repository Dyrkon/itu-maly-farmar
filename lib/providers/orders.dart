import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:provider/provider.dart';

class Orders with ChangeNotifier {
  var orderIndex = 0;
  final _fireStoreInstance = FirebaseFirestore.instance;

  final List<Order> _orders = [
    Order(
      "1",
      Status.pending,
      10,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "2",
      Status.pending,
      10,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "3",
      Status.confirmedBySeller,
      10,
      DateTime.now(),
      DateTime.now(),
    ),
    Order(
      "4",
      Status.pending,
      10,
      DateTime.now(),
      DateTime.now(),
    ),
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
    _fireStoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element); // TODO
      });
    });
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
      print("succes"); // TODO handle error
    });
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

  void denyOrder(String id) {
    activeOrders.firstWhere((element) {
      if (element.id == id) {
        return true;
      } else {
        return false;
      }
    }).status = Status.denied;
    notifyListeners();
  }

  void confirmOrder(String id) {
    var order = activeOrders.firstWhere((element) {
      if (element.id == id) {
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
    notifyListeners();
  }
}
