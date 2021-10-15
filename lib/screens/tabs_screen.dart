import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:provider/provider.dart';

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
    const FarmersProductsScreen(),
    const ProductsScreen(),
    const SettingsScreen(),
    const SettingsScreen(),
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
        title: Text(
          "Malý farmář",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CustomIcons.cog,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
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
        items: [
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
