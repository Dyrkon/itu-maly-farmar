import 'package:flutter/material.dart';
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
      ],
      child: MaterialApp(
        theme: ThemeData(
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.black,
          ),
          fontFamily: "Roboto",
          primarySwatch: Palette.farmersGreen,
          textTheme: ThemeData.light().textTheme.copyWith(
            headline1: const TextStyle(
              fontSize: 30,
            ),
            button: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: const TabsScreen(),// auth.isAuth ? TabsScreen() : LoginScreen(),
        // home: TabsScreen(),
        routes: {
          // HomeScreen.routName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
