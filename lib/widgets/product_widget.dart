import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget(this.product, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    var product = widget.product;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Palette.farmersGreen.shade50,
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 7,
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
                          "https://solidstarts.com/wp-content/uploads/when-can-babies-eat-eggs.jpg"))),
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
                      product.productName + " (" + product.unit + ")",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Celkem:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      product.totalAmount.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      " ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      "Dostupné:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      product.accessibleAmount.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      " ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      "Rezervováno:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      product.reservedAmount.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
