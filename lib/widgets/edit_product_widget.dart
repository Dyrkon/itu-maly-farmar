import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/providers/products.dart';
import 'input_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  FirebaseFirestore firestorm = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _amount = TextEditingController();

    return SizedBox(
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? size.height * 1.75 / 6
                : 0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height * 0.3,
            width: size.width * 8 / 10,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                        CustomIcons.minus,
                        color: Colors.white,
                        size: 15,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        primary:
                            Palette.farmersGreen.shade500, // <-- Button color
                      ),
                    ),
                    Container(
                      child: inputField("", _amount, false, size.width / 5, 50),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
              Container(
                height: size.height / 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Expanded(
                          flex: 1,
                          child: Icon(
                            CustomIcons.trash,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(15),
                          primary: Colors.red, // <-- Button color
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
