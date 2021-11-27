import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class FarmersProductsScreen extends StatelessWidget {
  const FarmersProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              itemCount: productData.products.length,
              itemBuilder: (BuildContext ctx, int index) {
                return TextButton(
                  onPressed: () => {},
                  child: ProductWidget(
                    productData.products[index],
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: const Text(
              "+",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
