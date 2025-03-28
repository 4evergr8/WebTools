import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地址'),
      ),
      body: Center(
        child: Text('地址 Screen'),
      ),
    );
  }
}