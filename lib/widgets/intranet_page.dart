import 'package:flutter/material.dart';

class IntranetPage extends StatelessWidget {
  const IntranetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('内网'),
      ),
      body: Center(
        child: Text('内网 Screen'),
      ),
    );
  }
}