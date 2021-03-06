import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:maly_farmar/screens/landing_page.dart';
import 'package:maly_farmar/screens/login_screen.dart';
import 'package:provider/provider.dart';
import './colors/colors.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/tabs_screen.dart';
import './providers/tabs.dart';
import './providers/auth.dart';
import 'package:maly_farmar/providers/offers.dart';
import './screens/product_detail_screen.dart';

//autor: Matěj Mudra
//
//
//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print("start");
    // print(FirebaseAuth.instance.currentUser?.uid);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Tabs()),
        ChangeNotifierProvider.value(value: UserProvider(
            UserProfile(FirebaseAuth.instance.currentUser?.uid,
            FirebaseAuth.instance.currentUser?.email),
            FirebaseFirestore.instance)),
        ChangeNotifierProvider.value(value: Products(FirebaseFirestore.instance,
            FirebaseAuth.instance.currentUser?.uid)),
        ChangeNotifierProvider.value(value: Orders(FirebaseFirestore.instance,
            FirebaseAuth.instance.currentUser?.uid)),
        ChangeNotifierProvider.value(value: Offers(FirebaseFirestore.instance)),
        Provider<Auth>(
          create: (_) => Auth(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Auth>().authStateChanges, initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          home: const AuthenticationWrapper(),
          // home: TabsScreen(),
          routes: {
            LandingPage.routeName: (ctx) => const LandingPage(),
            ProductsDetailScreen.routeName: (ctx) => ProductsDetailScreen(),
          },
        ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const TabsScreen();
    }
    return LoginScreen();
  }
}
