import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 用于访问剪贴板

// 弹窗函数
void showTextPopup(BuildContext context, String text) {
  final theme = Theme.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('详细信息', style: theme.textTheme.headlineMedium),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6, // 弹窗宽度占屏幕宽度的 60%
            maxHeight: MediaQuery.of(context).size.height * 0.5, // 弹窗高度占屏幕高度的 50%
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: TextField(
                    readOnly: true, // 文本框只读
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '内容',
                    ),
                    controller: TextEditingController(text: text),
                    maxLines: null, // 自动换行
                    minLines: 1, // 最小行数
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: text)); // 复制到剪贴板
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('内容已复制到剪贴板')),
                      );
                    },
                    child: Text('复制'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭弹窗
                    },
                    child: Text('确定'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}