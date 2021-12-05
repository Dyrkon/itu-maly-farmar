import 'package:flutter/material.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:provider/provider.dart';

class FarmerWidget extends StatefulWidget {
  final Offer offer;

  const FarmerWidget(this.offer, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FarmerWidgetState();
}

class _FarmerWidgetState extends State<FarmerWidget> {
  @override
  Widget build(BuildContext context) {
    var offer = widget.offer;

    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1 / 9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: Provider.of<Products>(context).getProductImage(offer.id),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData || snapshot.hasError) {
                  return Container(
                    width: MediaQuery.of(context).size.height * 1 / 9,
                    height: MediaQuery.of(context).size.height * 1 / 9,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10)),
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
                    width: MediaQuery.of(context).size.height * 1 / 9,
                    height: MediaQuery.of(context).size.height * 1 / 9,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(10)),
                    ),
                    child: const CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 1 / 3.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          offer.seller.fullName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Flexible(
                        flex: 1,
                        child: Text("+ X km"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 1 / 3.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          "${offer.accessibleAmount} ${offer.unit}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          "${offer.price} Kč/ks",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
