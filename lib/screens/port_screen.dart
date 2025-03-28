import 'package:flutter/material.dart';

class PortScreen extends StatelessWidget {
  const PortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('端口'),
      ),
      body: Center(
        child: Text('端口 Screen'),
      ),
    );
  }
}