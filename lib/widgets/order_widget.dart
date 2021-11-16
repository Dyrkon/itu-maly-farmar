import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/order.dart';
import '../colors/colors.dart';

class OrderWidget extends StatefulWidget {
  final String product;
  final String name;
  bool isConfirmed;
  int quantity;
  DateTime date;

  OrderWidget(
      this.product, this.name, this.quantity, this.date, this.isConfirmed,
      {Key? key})
      : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            (widget.isConfirmed ? Palette.farmersGreen.shade300 : Colors.white),
      ),
      child: Row(
        children: [
          Container(
              // child: Image.asset(""),
              ),
          Column(
            children: [
              Text(widget.product),
              const Text("Množství:"),
              Text(widget.quantity.toString()),
            ],
          ),
          Column(
            children: [
              Text(widget.name),
              const Text("Datum"),
              Text(widget.date.day.toString() +
                  " " +
                  widget.date.month.toString()),
            ],
          ),
          widget.isConfirmed
              ? const SizedBox.shrink()
              : const Icon(CustomIcons.cross),
          widget.isConfirmed
              ? const SizedBox.shrink()
              : const Icon(CustomIcons.check),
        ],
      ),
    );
  }
}
