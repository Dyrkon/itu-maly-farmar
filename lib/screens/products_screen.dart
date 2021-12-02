import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:maly_farmar/widgets/farmer_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
  final productData = Provider.of<Products>(context);
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget> 
            [
              Row( // row for the two dropdown forms
                children: [
                  // TODO dropdowns
                  StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("products").snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        Text("Loading");
                      } else {
                        List<DropdownMenuItem> productsItems=[];
                        for(int i = 0; i < snapshot.data.documents.length; i++) {
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          productsItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.documentID,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: "${snap.DocumentID}",
                            ),
                          );
                        }
                        Return Container(
                          DropdownButton(
                            items: items)
                        ),
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: productData.fetchProducts,
          child: ListView.builder(
                  itemCount: productData.products.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (index > 0) {
                      return RawMaterialButton(
                        onLongPress: () => {},
                        onPressed: () => {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: FarmerWidget(
                            productData.products[index],
                            // TODO user argument
                          ),
                        ),
                      );
                    }
                    else
                      {
                        return const SizedBox(height: 50,);
                      }
                  }),
          )
      ),

    );
  }
}
