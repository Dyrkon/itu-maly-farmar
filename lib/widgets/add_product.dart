import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'input_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int? dropdownValue;
  bool invalidInput = false;
  bool outOfBrackets = true;
  FirebaseFirestore firestorm = FirebaseFirestore.instance;
  final productID = DateTime.now().toString();
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    dropdownValue ??= 0;
    var dropDownValues = ["ks", "g", "dg", "kg", "t", "ml", "l"];
    TextEditingController _name = TextEditingController();
    TextEditingController _amount = TextEditingController();
    TextEditingController _price = TextEditingController();
    TextEditingController _description = TextEditingController();

    return SizedBox(
      //padding: EdgeInsets.symmetric(horizontal: 2),
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? size.height * 1 / 6
                : 0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height * 0.55,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Nová položka",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Přidejte obrázek:",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Palette.farmersGreen,
                                borderRadius: BorderRadius.circular(10)),
                            child: FutureBuilder(
                                future: Provider.of<Products>(context)
                                    .getProductImage(productID),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  print("Has");
                                  print(snapshot.hasData);
                                  print("Err");
                                  print(snapshot.hasError);
                                  print(snapshot.data);
                                  if (snapshot.hasData && snapshot.data != "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1") {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else if (snapshot.hasError ||snapshot.data == "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1") {
                                    return RawMaterialButton(
                                      splashColor: Palette.farmersGreen,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      onPressed: () async => {
                                        imageUrl = await Provider.of<Products>(context, listen: false).uploadProductPhoto(productID),
                                      },
                                      child: const Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Center(child: CircularProgressIndicator(),);
                                  }
                                }),
                          ),
                        ],
                      ),
                      inputField("Zadejte název položky", _name, false,
                          size.width, 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          inputField("Zadejte množství", _amount, false,
                              size.width * 5 / 8, 50),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Material(
                              child: DropdownButton(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: const Icon(
                                  CustomIcons.arrow_circle_down,
                                  color: Palette.farmersGreen,
                                ),
                                items: dropDownValues.map((String e) {
                                  return DropdownMenuItem(
                                    value: dropDownValues.indexOf(e),
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    dropdownValue = value as int;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      inputField("Zadejte cenu za položku", _price, false,
                          size.width, 50),
                      inputField("Přidejte popis", _description, false,
                          size.width, 50),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Palette.farmersGreen.shade500),
                      ),
                      child: const Text("Přidej produkt"),
                      onPressed: () async {
                        try {
                          var value = double.parse(_amount.text);
                          if (value <= 0 || value % 1 != 0) {
                            Fluttertoast.showToast(
                                msg: "Množství musí být kladné celé číslo",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            invalidInput = true;
                            outOfBrackets = false;
                          }
                          value = double.parse(_price.text);
                          if (value <= 0 || value % 1 != 0) {
                            Fluttertoast.showToast(
                                msg: "Cena musí být kladné celé číslo",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            invalidInput = true;
                            outOfBrackets = false;
                          }
                        } on FormatException {
                          invalidInput = true;
                          outOfBrackets = false;
                        } finally {
                          if (outOfBrackets) {
                            invalidInput = false;
                          }
                        }
                        outOfBrackets = true;

                        //name amount price description
                        if (_name.text == "" ||
                            _amount.text == "" ||
                            _price.text == "" ||
                            _description.text == "") {
                          Fluttertoast.showToast(
                              msg: "Nejsou zadány všechny informace",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (invalidInput) {
                          Fluttertoast.showToast(
                              msg: "Cenu a množství zadejte číslem",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          var newProduct = Product(
                              productID,
                              _name.text.trim(),
                              productID,
                              dropDownValues[dropdownValue!.toInt()],
                              int.parse(_amount.text.trim()),
                              int.parse(_amount.text.trim()),
                              0,
                              int.parse(_price.text.trim()),
                              _description.text.trim());
                          newProduct.imagePath = imageUrl;
                          if (await Provider.of<Products>(context, listen: false).pushProduct(newProduct) == false) {
                            Fluttertoast.showToast(
                                msg:
                                    "Nepodařilo se přidat produkt. Zkontrolujte internetové připojení.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Provider.of<Products>(context, listen: false).fetchProducts();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
