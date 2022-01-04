import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:maly_farmar/screens/product_detail_screen.dart';
//import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:maly_farmar/widgets/farmer_widget.dart';
import 'package:maly_farmar/widgets/product_widget.dart';
import 'package:provider/provider.dart';
import 'package:maly_farmar/providers/offers.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:fluttertoast/fluttertoast.dart';

//autor: Adam Jetmar
//
//
//
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var offerData = Provider.of<Offers>(context);
    var _user = Provider.of<UserProvider>(context);
    var geopoint;

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
                            child: ElevatedButton(
                              onPressed: () => {
                                showDialog(
                                    barrierColor: Colors.grey.withOpacity(0.9),
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1 /
                                                5,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Zadejte co chete vyhledat:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      1 /
                                                      3.3,
                                                  child: TextField(
                                                    controller: search,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Provider.of<Offers>(
                                                              context,
                                                              listen: false)
                                                          .fetchSearchedOffers(
                                                              search.text
                                                                  .toString());
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                        const Text("Vyhledat")),
                                              ],
                                            ),
                                          ),
                                        ))
                              },
                              child: const Text("Vyberte si produkt"),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                Fluttertoast.showToast(
                                    msg: "Zjišťuji polohu",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                geopoint = await _user.determinePosition();
                                if (geopoint.latitude == 90 &&
                                    geopoint.longitude == 180) {
                                  Fluttertoast.showToast(
                                      msg: "Nebylo možné získat polohu",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Poloha úspěšně nastavena!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  _user.user.location = geopoint;
                                  //Provider.of<UserProvider>(context, listen: false).updateUserData(Provider.of<UserProvider>(context).userID, _user.user);
                                  Fluttertoast.showToast(
                                      msg: "Změny uloženy",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: const Text("Zvolte svou polohu"),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // print(offerData.offers[index -1].seller);
                    return RawMaterialButton(
                      onPressed: () {
                        offerData.currentOffer = index - 1;
                        Navigator.of(context)
                            .pushNamed(ProductsDetailScreen.routeName);
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
