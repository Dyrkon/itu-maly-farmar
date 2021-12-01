import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:provider/src/provider.dart';
import '../widgets/input_field_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();

  String nameField = "Zadejte své jméno a příjmení:";
  var addressField = "Zadejte svou adresu:";
  String phoneField = "Zadejte svůj telefon:";

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<UserProvider>(context).user;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Builder(builder: (context) {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              const SizedBox(
                                width: 60,
                              ),
                              TextButton(
                                onPressed: () {},
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
                          const SizedBox(
                            height: 20,
                          ),
                          inputField(nameField, 5,
                              _nameController, false, context),
                          inputField(addressField, 5,
                              _addressController, false, context),
                          inputField(phoneField, 5,
                              _numberController, false, context),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: TextButton(
                              onPressed: () => {
                                context.read<Auth>().signOut(),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: TextButton(
                              onPressed: Provider.of<UserProvider>(context, listen: false).fetchUserData,
                              child: const Text(
                                "Načíst údaje ze serveru",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
