import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import '../widgets/input_field_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool singUp = false;

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  Widget mainContent(buttonColor,Size deviceSize) {
    return SingleChildScrollView(
      reverse: true,
          child: SizedBox(
            height: deviceSize.height - 30,
            width: deviceSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CustomIcons.wheelchair,
                  color: Palette.farmersGreen,
                  size: 60,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Malý farmář",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                inputField("Váš email", 5, _nameController, false, context),
                inputField("Váše heslo", 5, _passwordController, true, context),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () => {
                      singUp
                          ? context.read<Auth>().singUp(
                        email: _nameController.text.trim(),
                        password: _passwordController.text.trim(),
                      ).then((value) {
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Zadali jste neplatné údaje. \nZkuste to znovu."),
                            title: Text("Neplatné přihlašovací údaje!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          );
                        });
                        _passwordController.clear();
                        _nameController.clear();
                      })
                          : context.read<Auth>().singIn(
                        email: _nameController.text.trim(),
                        password: _passwordController.text.trim(),
                      ).then((value) {
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Zadali jste neplatné údaje. \nZkuste to znovu."),
                            title: Text("Neplatné přihlašovací údaje!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          );
                        });
                        _passwordController.clear();
                        _nameController.clear();
                      })
                    },
                    child: Text(
                      singUp ? "Registrovat se" : "Přihlásit",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: TextButton(
                    onPressed: () => {
                      setState(() {
                        if (singUp) {
                          singUp = false;
                        } else {
                          singUp = true;
                        }
                      })
                    },
                    child: Text(
                      singUp ? "Přihlásit se" :"Registrovat se",
                      style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var _buttonColor = Theme.of(context).primaryColor;
    var _deviceSize = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: mainContent(_buttonColor, _deviceSize),
      ),
    );
  }
}
