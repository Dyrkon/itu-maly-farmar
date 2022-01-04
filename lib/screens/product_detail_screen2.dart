import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/providers/offers.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:provider/provider.dart';

//autor: Adam Jetmar
//
//
//
class ProductsDetailScreen extends StatefulWidget {
  const ProductsDetailScreen({Key? key}) : super(key: key);

  static const routeName = "/product-detail-screen";

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final offerData = Provider.of<Offers>(context);
    final Offer offer = offerData.offers[offerData.currentOffer];

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Palette.farmersGreen.shade50, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: Provider.of<UserProvider>(context).getUserImage(offer.seller.id),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData || snapshot.hasError) {
                            return Container(
                              padding: const EdgeInsets.only(left: 0, right: 10),
                              width: MediaQuery.of(context).size.height / 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    snapshot.data ?? "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1",
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.only(left: 0, right: 10),
                              width: MediaQuery.of(context).size.height / 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1.85 / 3,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        offer.seller.fullName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Přerov",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder(
                        future: Provider.of<Products>(context).getProductImage(offer.id),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData || snapshot.hasError) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    snapshot.data ?? "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1",
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                              ),
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        offer.description,
                        maxLines: 7,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "dostupné:",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${offer.accessibleAmount} ${offer.unit}",
                            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "cena:",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${offer.price} Kč/${offer.unit}",
                            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width * 1.5,
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => {},
                          child: const Text(
                            "zarezervovat",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
