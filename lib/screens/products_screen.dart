import 'package:flutter/material.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return const SafeArea(
      child: Scaffold(
        body: Center(child: Text("Farmers product screen"),),
      ),

    );
  }
}
