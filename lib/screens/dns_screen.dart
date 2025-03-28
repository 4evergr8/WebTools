import 'package:flutter/material.dart';

class DNSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取当前主题
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DNS', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          'DNS Screen',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}