import 'package:flutter/material.dart';

class PortScreen extends StatelessWidget {
  const PortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('端口', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          '端口 Screen',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}