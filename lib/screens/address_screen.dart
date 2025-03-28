import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // 控制器，用于获取输入框的值
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 假设设备当前所在子网的地址是192.168.123.111
    _startController.text = '192.168.123.1'; // 起始地址
    _endController.text = '192.168.123.255'; // 结束地址
    _timeController.text = '100'; // 默认值100
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('地址', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 起始地址输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _startController,
                decoration: InputDecoration(
                  labelText: '起始地址',
                ),
              ),
            ),
            // 结束地址输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _endController,
                decoration: InputDecoration(
                  labelText: '结束地址',
                ),
              ),
            ),
            // 时间输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: '时间',
                  suffixText: 'ms',
                ),
              ),
            ),
            // 扫描按钮
            ElevatedButton.icon(
              onPressed: () {
                // 获取输入框的内容
                String start = _startController.text;
                String end = _endController.text;
                String time = _timeController.text;
                // 调用扫描函数
                _scan(start, end, time);
              },
              icon: Icon(Icons.search), // 使用搜索图标
              label: Text('扫描'),
            ),
          ],
        ),
      ),
    );
  }

  // 扫描函数
  void _scan(String start, String end, String time) {
    // 在这里实现扫描逻辑
    print('起始地址：$start');
    print('结束地址：$end');
    print('时间：$time ms');
  }
}