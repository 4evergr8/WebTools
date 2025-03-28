import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '/service/scan_port.dart';

class PortScreen extends StatefulWidget {
  const PortScreen({super.key});

  @override
  _PortScreenState createState() => _PortScreenState();
}

class _PortScreenState extends State<PortScreen> {
  // 控制器，用于获取输入框的值
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _startPortController = TextEditingController();
  final TextEditingController _endPortController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();

  String _currentIp = 'Unknown'; // 当前设备的内网地址

  @override
  void initState() {
    super.initState();
    _getCurrentIp();
    _startPortController.text = '1'; // 起始端口默认值
    _endPortController.text = '65535'; // 终止端口默认值
    _timeoutController.text = '100'; // 超时时间默认值
  }

  // 获取当前设备的内网地址
  Future<void> _getCurrentIp() async {
    final NetworkInfo networkInfo = NetworkInfo();
    try {
      String? wifiIP = await networkInfo.getWifiIP();
      setState(() {
        _currentIp = wifiIP ?? 'Unknown';
        if (_currentIp != 'Unknown') {
          // 设置目标地址为子网的第一个设备
          _targetController.text = _calculateStartIp(_currentIp);
        }
      });
    } catch (e) {
      print('Failed to get current IP address: $e');
    }
  }

  // 根据当前设备的内网地址计算子网的第一个设备
  String _calculateStartIp(String currentIp) {
    List<String> parts = currentIp.split('.');
    parts[3] = '1';
    return parts.join('.');
  }

  // 调用测试函数
  void _startTest() {
    String target = _targetController.text;
    int startPort = int.tryParse(_startPortController.text) ?? 1;
    int endPort = int.tryParse(_endPortController.text) ?? 65535;
    int timeoutMs = int.tryParse(_timeoutController.text) ?? 100;

    // 调用测试函数，假设测试函数名为 port
    port(target, startPort, endPort, timeoutMs);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('端口', style: theme.textTheme.headlineMedium),
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
            // 目标地址输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _targetController,
                decoration: InputDecoration(
                  labelText: '目标地址（IP）',
                ),
              ),
            ),
            // 起始端口输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _startPortController,
                decoration: InputDecoration(
                  labelText: '起始端口',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            // 终止端口输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _endPortController,
                decoration: InputDecoration(
                  labelText: '终止端口',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            // 超时时间输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _timeoutController,
                decoration: InputDecoration(
                  labelText: '超时时间（毫秒）',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            // 测试按钮
            ElevatedButton.icon(
              onPressed: _startTest,
              icon: Icon(Icons.search), // 使用搜索图标
              label: Text('开始测试'),
            ),
          ],
        ),
      ),
    );
  }
}


