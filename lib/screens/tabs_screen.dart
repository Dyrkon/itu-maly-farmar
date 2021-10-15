import 'package:flutter/material.dart';
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
      _selectedPage = Provider.of<Tabs>(context).changeIndex(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    var tabsProvider = Provider.of<Tabs>(context);
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.wheelchair),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.wheelchair),
            label: "",
          ),
        ],
      ),
    );
  }
}
