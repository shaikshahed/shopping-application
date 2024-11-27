import 'package:flutter/material.dart';
import 'package:frontend/category_screen/category_names_screen.dart';
import 'package:frontend/add_to_cart_screen/cart_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/menu_screen.dart';

class BottomBarTabs extends StatefulWidget {
  const BottomBarTabs({super.key});

  @override
  State<BottomBarTabs> createState() => _BottomBarTabsState();
}

class _BottomBarTabsState extends State<BottomBarTabs> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions =[
    const HomeScreen(),
    const CartScreen(uuid: '',),
    const CategoryScreen(),
     MenuScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
     bottomNavigationBar: BottomNavigationBar(
      // backgroundColor: Colors.red,
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black,),
          activeIcon: Icon(Icons.home_filled, color: Colors.purple,),
          label: "",
  backgroundColor: Colors.white
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart, color: Colors.black,),
          activeIcon: Icon(Icons.add_shopping_cart_outlined, color: Colors.purple,),
          label: ""
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category, color: Colors.black,),
          activeIcon: Icon(Icons.category_outlined, color: Colors.purple,),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu, color: Colors.black,),
          activeIcon: Icon(Icons.menu, color: Colors.purple,),
          label: ""
        ),
      ]),
    );
  }
}