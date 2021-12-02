import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';

import 'input_field_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int? dropdownValue = 1;
    var dropDownValues = ["ks", "kg", "l", "g", "ml", "t", "dg"];
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
              height: MediaQuery.of(context).viewInsets.bottom == 0 ? size.height * 1 / 6 : 0,
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
                          const Text("Přidejte obrázek:",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Palette.farmersGreen,
                                borderRadius: BorderRadius.circular(10)),
                            child: RawMaterialButton(
                              splashColor: Palette.farmersGreen,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              onPressed: () => {},
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      inputField(
                          "Zadejte název položky", _name, false, size.width, 50),
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
                                onChanged: (Object? value) {},
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                        ],
                      ),
                      inputField(
                          "Zadejte cenu za položku", _price, false, size.width, 50),
                      inputField(
                          "Přidejte popis", _description, false, size.width, 80),
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
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text("Označit za splněné"),
                      onPressed: () {
                        Navigator.of(context).pop();
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
