import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  final Product product;
  final deny;
  final confirm;

  const OrderWidget(this.order, this.product, this.deny, this.confirm,
      {Key? key})
      : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    var order = widget.order;
    var product = widget.product;
    bool isConfirmed = order.status == Status.confirmedBySeller;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color:
                  isConfirmed ? Palette.farmersGreen.shade300 : Colors.white54,
              borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1 / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 1 / 10,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://solidstarts.com/wp-content/uploads/when-can-babies-eat-eggs.jpg"),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.productName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Množství:",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        order.orderedAmount.toString() + " " + product.unit,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.sellersName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Datum vyzvednutí",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        order.pickupTime.day.toString() +
                            ". " +
                            order.pickupTime.month.toString() +
                            ".",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  false// isConfirmed TODO
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 20,
                          child: IconButton(
                            onPressed: () {
                              widget.deny(order.id);
                            },
                            icon: const Icon(
                              CustomIcons.times,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 10//isConfirmed ? 0 : 10,
                  ),
                  false// isConfirmed TODO
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 20,
                          child: IconButton(
                            onPressed: () {
                              widget.confirm(order.id);
                            },
                            icon: const Icon(CustomIcons.check),
                            color: Colors.green,
                            iconSize: 20,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
