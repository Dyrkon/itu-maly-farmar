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
    var _user = Provider.of<UserProvider>(context);
    print(_user.user.id);
    // print("IDDD ");

        return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: _user.getUserDataByID(_user.user.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                UserProfile user = snapshot.data;
                _nameController.text = user.fullName;
                _addressController.text = user.location.toString();
                _numberController.text = user.phoneNumber;
                return Padding(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                        onPressed: () {
                                          Provider.of<UserProvider>(context, listen: false).uploadImage();
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                  inputField(nameField, _nameController, false,
                                      null, null),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  inputField(addressField, _addressController,
                                      false, null, null),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  inputField(phoneField, _numberController,
                                      false, null, null),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 1/2,
                                    child: ElevatedButton(
                                        onPressed: () {
                                      var userData = UserProfile(
                                          user.id,
                                          user.email,
                                      );
                                      userData.phoneNumber = _numberController.text.trim();
                                      userData.fullName = _nameController.text.trim();
                                      // user.location = _addressController.text;
                                      Provider.of<UserProvider>(context,
                                          listen: false)
                                          .updateUserData(user.id, userData);
                                    }, child: Text("Uložit údaje")),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80),
                                    child: TextButton(
                                      onPressed: () {
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .fetchUserData(user.id);
                                        _nameController.text =
                                            user.fullName;
                                        _addressController.text =
                                            user.location.toString();
                                        _numberController.text =
                                            user.phoneNumber;
                                      },
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
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Nastala chyba"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
