import 'package:flutter/material.dart';
import '/screens/dns_screen.dart';
import '/screens/address_screen.dart';
import '/screens/port_screen.dart';
import '/screens/python_screen.dart';
import '/screens/history_screen.dart';
import 'util.dart'; // 假设 util.dart 包含 createTextTheme 函数
import 'theme.dart'; // 假设 theme.dart 包含 MaterialTheme 类

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // 创建自定义的主题
    TextTheme textTheme = createTextTheme(context, "Noto Sans", "Noto Sans");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: BottomNavBar(), // 使用底部导航栏组件
    );
  }
}

// 底部导航栏组件
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