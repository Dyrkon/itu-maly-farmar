import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  TextEditingController _amount = TextEditingController();
  int? amount;
  bool? toOffer;

  @override
  Widget build(BuildContext context) {
    var product = widget.targetProduct;
    toOffer ??= product.offered;
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
            width: size.width * 9 / 10,
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
                          controller: _amount,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: text,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (val) {
                            amount = int.parse(val);
                            text = amount.toString();
                          },
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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "nabídnout položku k prodeji?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Material(
                      child: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                            value: toOffer,
                            fillColor: MaterialStateProperty.all(Palette.farmersGreen.shade500),
                            onChanged: (bool? value) {
                              setState(() {
                                toOffer = value!;
                              });
                            }),
                      ),
                    )
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
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (int.parse(_amount.text) != amount) {
                              int newAmount = int.parse(_amount.text);
                              if (newAmount % 1 == 0) {
                                amount = newAmount;
                              }
                            }
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
                              Provider.of<Products>(context, listen: false).updateProduct(product, amount!, toOffer!);
                              Navigator.of(context).pop();
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
