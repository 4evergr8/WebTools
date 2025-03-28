import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('地址', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          '地址 Screen',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}