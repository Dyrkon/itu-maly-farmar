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
  Widget noProducts(provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              "Nemáte žádné produkty, můžete je vytvořit, nebo zkusit načíst",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: provider.fetchProducts,
              child: const Text(
                "Načíst produkt",
              ),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: productData.fetchProducts,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: productData.products.isEmpty
                ? noProducts(productData)
                : ListView.builder(
                    itemCount: productData.products.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      if (index < productData.products.length - 1) {
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
                      } else {
                        return const SizedBox(
                          height: 50,
                        );
                      }
                    }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                barrierColor: Colors.grey.withOpacity(0.9),
                context: context,
                builder: (BuildContext context) => AddProduct());
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
