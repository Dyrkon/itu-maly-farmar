import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:maly_farmar/widgets/farmer_widget.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';
import 'package:maly_farmar/providers/offers.dart';
import 'package:maly_farmar/models/offer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
  final offerData = Provider.of<Offers>(context);
  var selectedType;
  List<String> _productsType=<String>[
    'Vejce',
    'Slepice',
    'Mléko',
    'Prase'
  ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget> 
            [
              Row( // row for the two dropdown forms
                children: <Widget>[
                DropdownButton(
                  items: _productsType.map((value)=>DropdownMenuItem(
                    child: Text(
                      value
                    ),
                    value: value,
                    )).toList(),
                  onChanged: (selectedProductsType) {
                    setState(() {
                      selectedType = selectedProductsType;
                    });
                  },
                  value: selectedType,
                ),
              ],  
          ),
        ],     
        ),
        body: RefreshIndicator(
          onRefresh: offerData.fetchOffers,
          child: ListView.builder(
                  itemCount: offerData.offers.length, // WHAAAAAAAAAAAAAAAAAAAAAAAAAT
                  itemBuilder: (BuildContext ctx, int index) {
                    if (index > 0) {
                      return RawMaterialButton(
                        onLongPress: () => {},
                        onPressed: () => {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: FarmerWidget(
                            offerData.offers[index],
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


/*
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
                            items: productItems,
                        ),
                      }
                    },
                  ),
                ],
              ),
              */