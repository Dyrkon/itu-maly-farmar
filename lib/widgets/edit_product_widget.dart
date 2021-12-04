import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  Product targetProduct;
  EditProduct(this.targetProduct, {Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  FirebaseFirestore firestorm = FirebaseFirestore.instance;
  int? amount;

  @override
  Widget build(BuildContext context) {
    var product = widget.targetProduct;
    amount ??= product.accessibleAmount;
    String text = amount.toString();
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom == 0 ? size.height * 1.75 / 6 : size.height * 1.5 / 6,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height * 0.28,
            width: size.width * 8 / 10,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Upravte množství",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.fade,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          amount = (amount! - 1);
                          text = amount.toString();
                        });
                      },
                      child: const Icon(
                        CustomIcons.minus,
                        color: Colors.white,
                        size: 15,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        primary: Palette.farmersGreen.shade500, // <-- Button color
                      ),
                    ),
                    SizedBox(
                      width: size.width / 5,
                      height: size.height,
                      child: Material(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: text,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          amount = (amount! + 1);
                          text = amount.toString();
                        });
                      },
                      child: const Icon(
                        CustomIcons.plus,
                        color: Colors.white,
                        size: 15,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        primary: Palette.farmersGreen.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            CustomIcons.times,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(15),
                            primary: Palette.farmersGreen.shade500, // <-- Button color
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                amount = 0;
                                text = amount.toString();
                              });
                            },
                            child: const Icon(
                              CustomIcons.trash,
                              color: Colors.white,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.red, // <-- Button color
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (amount! < 0 || amount! % 1 != 0) {
                              Fluttertoast.showToast(
                                  msg: "Zadejte nezáporné celé číslo.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              if (await Provider.of<Products>(context, listen: false).updateProduct(product, amount!) == false) {
                                Fluttertoast.showToast(
                                    msg: "Nepodařilo se upravit množství. Zkontrolujte internetové připojení.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: const Icon(
                            CustomIcons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(15),
                            primary: Palette.farmersGreen.shade500, // <-- Button color
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
