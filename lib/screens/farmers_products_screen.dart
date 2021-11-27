import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/screens/landing_page.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class FarmersProductsScreen extends StatelessWidget {
  const FarmersProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (false /*!context.read<Auth>().firstTime*/) {
      return SafeArea(
        child: Scaffold(
          body: LandingPageWrapper(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Text(
              "+",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      );
    } else {
      return const SafeArea(
        child: Scaffold(
          body: LandingPageWrapper(),
        ),
      );
    }
  }
}

class LandingPageWrapper extends StatelessWidget {
  const LandingPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<Auth>().FirstTimeLogin();
    if (true /*context.read<Auth>().firstTime*/) {
      return Stack(
        children: [FarmersProducts(), const LandingPage()],
      );
    } else {
      return FarmersProducts();
    }
  }
}

class FarmersProducts extends StatelessWidget {
  FarmersProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Container(
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
    );
  }
}
