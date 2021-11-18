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
      height: MediaQuery.of(context).size.height * 1 / 9,
      decoration: BoxDecoration(
        color:
            (widget.isConfirmed ? Palette.farmersGreen.shade300 : Colors.white),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 12,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10)),
                    child: Image.network(
                        "https://solidstarts.com/wp-content/uploads/when-can-babies-eat-eggs.jpg"),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text("Množství:"),
                    Text(widget.quantity.toString() + " " + widget.unit,
                    style: const TextStyle(
                      fontSize: 20,
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Text(widget.farmersName),
                    const Text("Datum",
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                    Text(widget.date.day.toString() +
                        ". " +
                        widget.date.month.toString() + ".",
                    style: const TextStyle(
                      fontSize: 20,
                    ),),
                  ],
                ),
                widget.isConfirmed
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          print("neco");
                        },
                        icon: const Icon(
                          CustomIcons.times,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                widget.isConfirmed
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          print("neco2");
                        },
                        icon: const Icon(CustomIcons.check),
                color: Colors.green,
                iconSize: 20,),
              ],
            ),
          ]),
    );
  }
}
