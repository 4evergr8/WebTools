import 'package:flutter/material.dart';

class DNSScreen extends StatelessWidget {
  const DNSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DNS'),
      ),
      body: Center(
        child: Text('DNS Screen'),
      ),
    );
  }
}