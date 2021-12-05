import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import '../widgets/input_field_widget.dart';

//autor: Matěj Mudra
//
//
//
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool singUp = false;

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  Widget mainContent(buttonColor, Size deviceSize) {
    return SizedBox(
      height: deviceSize.height,
      width: deviceSize.width,
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CustomIcons.carrot, //carrot
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
              inputField("Váš email", _nameController, false, null, null, false),
              const SizedBox(
                height: 10,
              ),
              inputField("Váše heslo", _passwordController, true, null, null, false),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () => {
                    singUp
                        ? context
                            .read<Auth>()
                            .signUp(
                              email: _nameController.text.trim(),
                              password: _passwordController.text.trim(),
                            )
                            .then((value) {
                            context.read<Auth>().invalidCredentialsAlert(value, context, _nameController, _passwordController);
                          })
                        : context
                            .read<Auth>()
                            .signIn(
                              email: _nameController.text.trim(),
                              password: _passwordController.text.trim(),
                            )
                            .then((value) {
                            context.read<Auth>().invalidCredentialsAlert(value, context, _nameController, _passwordController);
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
                    singUp ? "Přihlásit se" : "Registrovat se",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _buttonColor = Theme.of(context).primaryColor;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          return mainContent(_buttonColor, MediaQuery.of(context).size);
        }),
      ),
    );
  }
}
