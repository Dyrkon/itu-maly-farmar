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

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
        inputField("Váš email", 5, _nameController, false, context),
        inputField("Váše heslo", 5, _passwordController, true, context),
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
