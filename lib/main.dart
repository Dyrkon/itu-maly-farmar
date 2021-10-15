import 'package:flutter/material.dart';
import 'package:maly_farmar/screens/login_screen.dart';
import 'icons/custom_icons.dart';
import 'package:provider/provider.dart';
import './colors/colors.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/tabs_screen.dart';
import './providers/tabs.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Tabs()),
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.black,
            ),
            fontFamily: "Roboto",
            canvasColor: Colors.white,
            primarySwatch: Palette.farmersGreen,
            errorColor: Colors.red,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: const TextStyle(
                    fontSize: 30,
                  ),
                  button: const TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
          home: TabsScreen(), // auth.isAuth ? TabsScreen() : LoginScreen(),
          // home: TabsScreen(),
          routes: {},
        ),
      ),
    );
  }
}
