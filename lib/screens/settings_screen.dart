import 'package:flutter/material.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:provider/src/provider.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nastavení",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Přidejte svou fotku:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 60,),
                  TextButton(
                    onPressed: () {  },
                    child: Stack(
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
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              inputField("Zadejte své jméno a příjmení:", 5, _nameController, false, context),
              inputField("Zadejte svou adresu:", 5, _addressController, false, context),
              inputField("Zadejte svůj telefon:", 5, _numberController, false, context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextButton(
                  onPressed: () => {
                    context.read<Auth>().singOut(),
                  },
                  child: const Text(
                    "Odhlásit se",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
