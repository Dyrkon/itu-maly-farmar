import 'package:flutter/material.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/screens/landing_page.dart';
import 'package:maly_farmar/widgets/add_product.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class FarmersProductsScreen extends StatefulWidget {
  const FarmersProductsScreen({Key? key}) : super(key: key);

  @override
  State<FarmersProductsScreen> createState() => _FarmersProductsScreenState();
}

class _FarmersProductsScreenState extends State<FarmersProductsScreen> {

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: productData.fetchProducts,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  itemCount: productData.products.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (index < productData.products.length-1) {
                      return RawMaterialButton(
                        onLongPress: () => {},
                        onPressed: () => {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ProductWidget(
                            productData.products[index],
                          ),
                        ),
                      );
                    }
                    else
                      {
                        return const SizedBox(height: 50,);
                      }
                  }),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, "/landing-page");
            showDialog(
              barrierColor: Colors.grey.withOpacity(0.9),
                context: context, builder: (BuildContext context) => AddProduct());
          },
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
