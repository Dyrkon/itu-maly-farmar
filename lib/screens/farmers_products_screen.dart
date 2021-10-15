import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';

class FarmersProductsScreen extends StatelessWidget {
  const FarmersProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(child: Text("Farmers"),),
        ),

    );
  }
}

