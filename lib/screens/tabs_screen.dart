import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'settings_screen.dart';
import 'farmers_products_screen.dart';
import 'orders_screen.dart';
import 'products_screen.dart';
import '../providers/tabs.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    FarmersProductsScreen(),
    ProductsScreen(),
    SettingsScreen(),
    OrdersScreen(),
  ];

  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage =
          Provider.of<Tabs>(context, listen: false).changeIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Malý farmář",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            CustomIcons.cog,
            color: Colors.black,
          ),
          onPressed: () =>
              Provider.of<Tabs>(context, listen: false).changeIndex(2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<Tabs>(context, listen: false).changeIndex(3),
            icon: const Icon(
              CustomIcons.list,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _pages[Provider.of<Tabs>(context).screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.tractor,
              // color: Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.store,
              // color: Colors.black,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
