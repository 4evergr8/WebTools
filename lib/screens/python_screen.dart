import 'package:flutter/material.dart';

class PythonScreen extends StatelessWidget {
  const PythonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Python插件'),
      ),
      body: Center(
        child: Text('Python插件 Screen'),
      ),
    );
  }
}