import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  Widget inputField(String text, padding,
      TextEditingController controller, bool obstruct) {
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
            if (Provider.of<Auth>(context, listen: false).isValid(val, context, controller) == false) {
              return;
            }
            obstruct == false ? Provider.of<Auth>(context, listen: false).email = val :
            Provider.of<Auth>(context, listen: false).password = val;
          },

        obscureText: obstruct,
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
        const SizedBox(
          height: 25,
        ),
        inputField("Váš email", 5, _nameController, false),
        inputField("Váše heslo", 5, _passwordController, true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
            onPressed: () => {
              Provider.of<Auth>(context, listen: false).login()
            },
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
