import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/screens/product_detail_screen.dart';
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
    var offerData = Provider.of<Offers>(context);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: offerData.fetchOffers,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: offerData.offers.length + 1,
                itemBuilder: (BuildContext ctx, int index) {
                  if (index == 0) {
                    return Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: ElevatedButton(onPressed: () => {}, child: const Text("Vyberte si produkt"),),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: ElevatedButton(onPressed: () => {}, child: const Text("Zvolte svou polohu"),),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // print(offerData.offers[index -1].seller);
                    return RawMaterialButton(
                      onPressed: () {
                        offerData.currentOffer = index - 1;
                        Navigator.of(context).pushNamed(ProductsDetailScreen.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: FarmerWidget(offerData.offers[index - 1]),
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
