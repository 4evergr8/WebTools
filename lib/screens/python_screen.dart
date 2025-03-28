import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PythonScreen extends StatefulWidget {
  const PythonScreen({super.key});

  @override
  _PythonScreenState createState() => _PythonScreenState();
}

class _PythonScreenState extends State<PythonScreen> {
  final String _fileName = 'aaa.txt';
  final String _folderName = 'aaa';

  Future<void> _createFileInAppDirectory() async {
    try {
      // 获取应用的文档目录
      final appDir = await getApplicationDocumentsDirectory();
      final folderPath = '${appDir.path}/$_folderName';

      // 创建文件夹
      final folder = Directory(folderPath);
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      // 创建文件
      final filePath = '$folderPath/$_fileName';
      final file = File(filePath);
      await file.writeAsString('Hello, this is a test file.');

      // 显示成功消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File created successfully at $filePath')),
      );
    } catch (e) {
      // 显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Python插件', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Python插件 Screen',
              style: theme.textTheme.bodyLarge,
            ),
            ElevatedButton(
              onPressed: _createFileInAppDirectory,
              child: Text('创建文件'),
            ),
          ],
        ),
      ),
    );
  }
}