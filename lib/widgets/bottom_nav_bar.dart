import 'package:flutter/material.dart';
import '/screens/dns_screen.dart';
import '/screens/address_screen.dart';
import '/screens/port_screen.dart';
import '/screens/python_screen.dart';
import '/screens/history_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    DNSScreen(),
    AddressScreen(),
    PortScreen(),
    PythonScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check),
            label: 'DNS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '地址',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_ethernet),
            label: '端口',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Python插件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '历史',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}