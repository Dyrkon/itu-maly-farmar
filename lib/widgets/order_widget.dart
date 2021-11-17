import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/order.dart';
import '../colors/colors.dart';

class OrderWidget extends StatefulWidget {
  final String productName;
  final String farmersName;
  final String unit;
  bool isConfirmed;
  int quantity;
  DateTime date;

  OrderWidget(this.productName, this.farmersName, this.quantity, this.date,
      this.isConfirmed, this.unit,
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
      child: Column(
          children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                // child: Image.asset(""),
                ),
            Column(
              children: [
                Text(widget.productName),
                const Text("Množství:"),
                Text(widget.quantity.toString() + " " + widget.unit),
              ],
            ),
            Column(
              children: [
                Text(widget.farmersName),
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
      ]),
    );
  }
}
