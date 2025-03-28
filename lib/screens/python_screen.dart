import 'package:flutter/material.dart';

class PythonScreen extends StatelessWidget {
  const PythonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Python插件', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          'Python插件 Screen',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}