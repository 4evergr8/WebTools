import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 用于打开浏览器链接

// 弹窗函数
void showLinkButtonsPopup(BuildContext context, List<List<String>> links) {
  final theme = Theme.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('链接选项', style: theme.textTheme.headlineMedium),
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
                  child: Column(
                    children: links.map((link) {
                      return ElevatedButton(
                        onPressed: () async {
                          // 打开链接
                          final uri = Uri.parse(link[1]);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('无法打开链接 ${link[1]}')),
                            );
                          }
                        },
                        child: Text(link[0]),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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