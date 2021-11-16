import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/order.dart';
import '../colors/colors.dart';

class OrderWidget extends StatelessWidget {
  final String product;
  final String name;
  int confirmed;
  int quantity;
  DateTime date;

  OrderWidget(this.product, this.name, this.quantity, this.date, this.confirmed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              // child: Image.asset(""),
              ),
          Column(
            children: [
              Text(product),
              const Text("Množství:"),
              Text(quantity.toString()),
            ],
          ),
          Column(
            children: [
              Text(name),
              const Text("Datum"),
              Text(date.day.toString() + " " + date.month.toString()),
            ],
          ),
           const Icon(CustomIcons.cross),
          const Icon(CustomIcons.check),
        ],
      ),
    );
  }
}
