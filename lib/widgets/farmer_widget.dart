import 'package:flutter/material.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:maly_farmar/providers/offers.dart';
import 'package:maly_farmar/models/offer.dart';

class FarmerWidget extends StatefulWidget {
  final Offer offer;

  // const FarmerWidget(this.farmer, this.product, {Key? key}) : super(key : key);
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
          border: Border.all(
            color: Colors.greenAccent.shade700,
            width: 1.5
            ),
          borderRadius: const BorderRadius.all(
            Radius.circular(7.0)
          ),
        ),
        /*decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),*/
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1 / 9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 1 / 9,
              height: MediaQuery.of(context).size.height * 1 / 9,
              child: Padding(
              padding: const EdgeInsets.all(2), // padding kolem obrazku 
              child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                 /* borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10)),*/
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                          "https://solidstarts.com/wp-content/uploads/when-can-babies-eat-eggs.jpg"))
                  ),
                  ),
                ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Expanded(
                    flex: 1,
                    child: Text(
                      offer.seller.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: Expanded(
                        flex: 1,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        child: 
                          Text(
                            offer.accessibleAmount.toString() +
                                offer.unit, 
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Expanded(
                        flex: 1,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        child: 
                          Text(
                            offer.price.toString() +
                                "Kč/" +
                                offer.unit, 
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
