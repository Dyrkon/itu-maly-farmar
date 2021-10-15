import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> _authData = {
    "name": "",
    "password": "",
  };

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool isEmail(String string) {
    if (string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  Widget inputField(String text, padding, String saveValue,
      TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Palette.farmersGreen),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        onSubmitted: (val) {
          if (saveValue.isEmpty) {
            // saveValue == "name" && !isEmail(val) ||
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                        Text("Zadali jste neplatné údaje. \nZkuste to znovu."),
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
            controller.clear();
            return;
          }
          _authData[saveValue] = val;
          // print("${_authData[saveValue]} $saveValue"); // TODO debug ...
        },
        obscureText: saveValue == "password" ? true : false,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget mainContent(buttonColor, deviceSize) {
    return Column(
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
        const SizedBox(height: 25,),
        inputField("Váš email", 5, "name", _nameController),
        inputField("Váše heslo", 5, "password", _passwordController),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Přihlásit",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
          ),
        ),
      ],
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: _deviceSize.height > 650
            ? mainContent(_buttonColor, _deviceSize)
            : SingleChildScrollView(
                child: mainContent(_buttonColor, _deviceSize),
              ),
      ),
    );
  }
}
