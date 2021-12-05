import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/providers/offers.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:maly_farmar/widgets/make_order.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: const Text(
            "Malý farmář",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Palette.farmersGreen[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: Provider.of<UserProvider>(context)
                            .getUserImage(offer.seller.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData || snapshot.hasError) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 1 / 3.5,
                              height: MediaQuery.of(context).size.width * 1 / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    snapshot.data ??
                                        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1",
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width * 1 / 3.5,
                              height: MediaQuery.of(context).size.width * 1 / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 1 / 3.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.seller.fullName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              const Text(
                                "Misto",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future:
                      Provider.of<Products>(context).getProductImage(offer.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData || snapshot.hasError) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 8,
                        height: MediaQuery.of(context).size.width * 1 / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                              snapshot.data ??
                                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1",
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10)),
                        ),
                        child: const CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  offer.description,
                  style: const TextStyle(
                      fontSize: 18,
                      locale: Locale('cz'),
                      overflow: TextOverflow.fade),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Palette.farmersGreen[300],
                          ),
                          height: MediaQuery.of(context).size.width * 1 / 5,
                          width: MediaQuery.of(context).size.width * 1 / 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "dostupné:",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${offer.accessibleAmount} ${offer.unit}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Palette.farmersGreen[300],
                          ),
                          height: MediaQuery.of(context).size.width * 1 / 5,
                          width: MediaQuery.of(context).size.width * 1 / 3,
                        ),
                        Column(
                          children: [
                            const Text(
                              "cena:",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${offer.price} Kč/${offer.unit}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 14,),
                ElevatedButton(
                  onPressed: () => {
                    print("TEXTtEST"),
                  showDialog(
                  barrierColor: Colors.grey.withOpacity(0.9),
                  context: context,
                  builder: (BuildContext context) => MakeOrderWidget(offer))
                  },
                  child: const Text(
                    "Zarezervovat",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
