import 'package:flutter/material.dart';
import 'package:maly_farmar/providers/orders.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final size = MediaQuery.of(context).size;
    final productData = Provider.of<Products>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              itemCount: orderData.activeOrders.length,
              itemBuilder: (BuildContext ctx, int index) {
                return OrderWidget(
                  orderData.activeOrders[index],
                  productData.productWithId(orderData.activeOrders[index].id),
                  orderData.denyOrder,
                  orderData.confirmOrder,
                );
              }),
        ),
      ),
    );
  }
}
