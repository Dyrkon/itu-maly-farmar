import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/order.dart';

//autor: Matěj Mudra
//
//
//
class Orders with ChangeNotifier {
  var orderIndex = 0;
  final FirebaseFirestore _fireStoreInstance;
  final userId;

  Orders(
    this._fireStoreInstance,
    this.userId,
  );

  List<Order> _orders = [];
  List<String> _exterOrdersIDs = [];
  List<Order> _exterOrders = [];

  List<Order> get activeOrders {
    return [
      ..._orders.where((order) {
        if (order.status == Status.pending || order.status == Status.confirmedBySeller) {
          return true;
        } else {
          return false;
        }
      })
    ];
  }

  Future<void> fetchFarmersOrders() async {
    _orders.clear();

    await _fireStoreInstance.collection("users").get().then((QuerySnapshot querySnapshot) async {
      for (var element in querySnapshot.docs) {
        await _fireStoreInstance.collection("users").doc(element.id).collection("orders").get().then((value) {
          for (var element in value.docs) {
            if (element.exists) {
              Map<String, dynamic> target = element.data();
              if (target["productID"] != null) {
                _exterOrders.add(
                  Order(
                    target["orderID"],
                    target["productID"],
                    Status.values[target["status"]],
                    target["orderedAmount"],
                    target["orderTime"].toDate(),
                    target["pickupTime"].toDate(),
                  ),
                );
                _exterOrdersIDs.add(target["productID"]);
              }
            }
          }
        });
      }
    });

    for (var productID in _exterOrdersIDs) {
      await _fireStoreInstance.collection("products").where("id", isEqualTo: productID).where("sellersID", isEqualTo: "EpuTOI2JvaNhtPwLsFKmYFjL3Aj2").get().then((value) {
        for (var element in value.docs) {
          if (element.exists) {
            Map<String, dynamic> target = element.data();
            if (_exterOrdersIDs.any((element) {
              if (element == target["id"]) {
                return true;
              } else {
                return false;
              }
            })) {
              if (_orders.indexWhere((element) {
                    // print("HEJ1"+_exterOrders[_exterOrdersIDs.indexWhere((element) => element == target["id"])].orderID);
                    // print("HEJ2"+element.orderID);
                    if (_exterOrders[_exterOrdersIDs.indexWhere((element) => element == target["id"])].orderID == element.orderID) {
                      print("false");
                      return false;
                    } else {
                      print("true");
                      return true;
                    }
                  }) ==
                  -1) {
                _orders.removeWhere((element) => element.orderID == _exterOrders[_exterOrdersIDs.indexWhere((element) => element == target["id"])].orderID);
                _orders.add(_exterOrders[_exterOrdersIDs.indexWhere((element) => element == target["id"])]);
              }
            }
          }
        }
      });
    }

    notifyListeners();
  }

  Future<void> fetchOrders() async {
    _orders.clear();

    var snapshot = await _fireStoreInstance.collection("users").doc(userId).collection("orders").get();

    for (var element in snapshot.docs) {
      Map<String, dynamic> order = element.data();
      if (_orders.indexWhere((element) {
            if (element.orderID == order["orderID"]) {
              return true;
            }
            return false;
          }) ==
          -1) {
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
    }

    notifyListeners();
  }

  Future<bool> pushOrder(String userId, Order orderToAdd) async {
    bool exitValue = false;

    await _fireStoreInstance.collection("users").doc(userId).collection("orders").add({
      "orderID": orderToAdd.productID,
      "orderTime": orderToAdd.orderTime,
      "orderedAmount": orderToAdd.orderedAmount,
      "pickupTime": orderToAdd.pickupTime,
      "productID": orderToAdd.productID,
      "status": orderToAdd.status.index,
    }).then((value) {
      exitValue = true;
    });

    return exitValue;
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

    _fireStoreInstance.collection("users").doc(userId).collection("orders").doc(id).update({"status": status.index});
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
