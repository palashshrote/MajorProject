import 'package:flutter/material.dart';
import 'package:accident_detection/HomePage.dart';
import 'package:accident_detection/accident.dart';
import 'package:accident_detection/info.dart';
import 'package:accident_detection/bluetooth.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});
  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    AccidentButtonPage(),
    InfoPage(),
    // BluetoothPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            label: 'Homepage',
            icon: Icon(
              Icons.home,
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            label: 'Detect Accident',
            icon: Icon(
              Icons.two_wheeler,
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            label: 'Info',
            icon: Icon(
              Icons.info,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
