import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '/service/scan_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // 控制器，用于获取输入框的值
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String _currentIp = 'Unknown'; // 当前设备的内网地址

  @override
  void initState() {
    super.initState();
    _getCurrentIp();
    _timeController.text = '50'; // 设置时间输入框的默认值为 50
  }

  // 获取当前设备的内网地址
  Future<void> _getCurrentIp() async {
    final NetworkInfo networkInfo = NetworkInfo();
    try {
      String? wifiIP = await networkInfo.getWifiIP();
      setState(() {
        _currentIp = wifiIP ?? 'Unknown';
        if (_currentIp != 'Unknown') {
          // 根据当前设备的内网地址计算起始地址和结束地址
          _startController.text = _calculateStartIp(_currentIp);
          _endController.text = _calculateEndIp(_currentIp);
        }
      });
    } catch (e) {
      print('Failed to get current IP address: $e');
    }
  }

  // 根据当前设备的内网地址计算起始地址
  String _calculateStartIp(String currentIp) {
    List<String> parts = currentIp.split('.');
    parts[3] = '1';
    return parts.join('.');
  }

  // 根据当前设备的内网地址计算结束地址
  String _calculateEndIp(String currentIp) {
    List<String> parts = currentIp.split('.');
    parts[3] = '255';
    return parts.join('.');
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
            // 显示当前设备的内网地址
            Text(
              '当前设备内网地址: $_currentIp',
              style: theme.textTheme.bodyLarge,
            ),
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
                int time = int.tryParse(_timeController.text) ?? 50; // 默认值为 50
                // 调用扫描函数
                address(start, end, time);
              },
              icon: Icon(Icons.search), // 使用搜索图标
              label: Text('扫描'),
            ),
          ],
        ),
      ),
    );
  }
}