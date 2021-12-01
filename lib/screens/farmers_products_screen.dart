import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import '../widgets/farmer_widget.dart';

class FarmersProductsScreen extends StatelessWidget {
  const FarmersProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          body: Center(child: farmerWidget()),
        ),
      );
  }
}

class LandingPageWrapper extends StatelessWidget {
  const LandingPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<Auth>().FirstTimeLogin();
    if (context.read<Auth>().firstTime) {
      return Stack(
        children: [FarmersProducts(),const LandingPage()],
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
    return RefreshIndicator(
      onRefresh: productData.fetchProducts,
      child: Container(
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
    );
  }
}

