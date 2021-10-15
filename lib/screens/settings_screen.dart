import 'package:flutter/material.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import '../widgets/input_field_widget.dart';

class SettingsScreen extends StatelessWidget {

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Nastavení",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Přidejte svou fotku:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 60,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Palette.farmersGreen,
                        ),
                        height: 100,
                        width: 80,
                      ),
                      const Icon(
                        CustomIcons.plus,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              inputField("Zadejte své jméno a příjmení:", 5, _nameController, false, context),
              inputField("Zadejte svou adresu:", 5, _addressController, false, context),
              inputField("Zadejte svůj telefon:", 5, _numberController, false, context),
            ],
          ),
        ),
      ),
    );
  }
}
