import 'package:flutter/material.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/providers/orders.dart';
import 'package:maly_farmar/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var listLength = 0;

  Widget noOrders(provider) {
    return Center(child: ElevatedButton(onPressed: provider.fetchOrders, child: const Text("Načíst produkty")));
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return RefreshIndicator(
      onRefresh: orderData.fetchOrders,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: orderData.activeOrders.isEmpty ? noOrders(orderData) : ListView.builder(
                itemCount: orderData.activeOrders.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return orderData.activeOrders[index].status !=
                          Status.confirmedByBuyer
                      ? OrderWidget(
                          orderData.activeOrders[index],
                          orderData.denyOrder,
                          orderData.confirmOrder,
                        )
                      : const SizedBox.shrink();
                }),
          ),
        ),
      ),
    );
  }
}
