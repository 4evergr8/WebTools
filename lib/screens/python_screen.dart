import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '/service/file_extractor.dart'; // 导入解压逻辑文件



class PythonScreen extends StatefulWidget {
  const PythonScreen({super.key});

  @override
  _PythonScreenState createState() => _PythonScreenState();
}

class _PythonScreenState extends State<PythonScreen> {


  Future<void> _pickAndExtractFile() async {
    try {
      // 使用 file_picker 选择文件
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final targetFolderName = 'plugin'; // 目标文件夹名称

        // 调用解压函数
        await extractFile(file, targetFolderName);

        // 显示成功消息
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File extracted successfully')),
        );
      }
    } catch (e) {
      // 显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to extract file: $e')),
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
        child: Text(
          'Python插件 Screen',
          style: theme.textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndExtractFile,
        child: Icon(Icons.add),
      ),
    );
  }
}