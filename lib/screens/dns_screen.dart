import 'package:flutter/material.dart';
import '/service/doh.dart';
import '/service/dot.dart';

class DNSScreen extends StatefulWidget {
  const DNSScreen({super.key});

  @override
  _DNSScreenState createState() => _DNSScreenState();
}

class _DNSScreenState extends State<DNSScreen> {
  bool _isDoh = true; // 默认为 DoH
  String _queryUrl = 'https://dns.alidns.com/dns-query'; // 默认 DoH 地址
  final String _queryPort = ':853'; // 默认 DoT 端口
  String _domain = 'baidu.com'; // 默认查询域名
  int _timeout = 5000; // 默认超时时长（毫秒）

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DNS', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 开关按钮
            SwitchListTile(
              value: _isDoh,
              onChanged: (value) {
                setState(() {
                  _isDoh = value;
                  if (_isDoh) {
                    _queryUrl = 'https://dns.alidns.com/dns-query'; // DoH 地址
                  } else {
                    _queryUrl = 'dns.alidns.com'; // DoT 地址
                  }
                });
              },
              title: Text(_isDoh ? 'DoH' : 'DoT'),
              subtitle: Text(_isDoh ? 'DNS over HTTPS' : 'DNS over TLS'),
            ),
            // 查询 URL 输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: _queryUrl),
                onChanged: (value) => setState(() => _queryUrl = value),
                decoration: InputDecoration(
                  labelText: _isDoh ? 'DoH URL' : 'DoT URL',
                  suffixText: _isDoh ? '' : _queryPort,
                ),
              ),
            ),
            // 查询域名输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: _domain),
                onChanged: (value) => setState(() => _domain = value),
                decoration: InputDecoration(
                  labelText: 'Domain',
                ),
              ),
            ),
            // 超时时长输入框
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: _timeout.toString()),
                onChanged: (value) {
                  setState(() {
                    _timeout = int.tryParse(value) ?? 5000; // 默认值为5000ms
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Timeout',
                  suffixText: 'ms', // 添加单位提示
                ),
                keyboardType: TextInputType.number, // 限制输入数字
              ),
            ),
            // 查询按钮
            ElevatedButton(
              onPressed: () {
                if (_isDoh) {
                  // 调用 DoH 查询函数
                  dohQuery(_queryUrl, _domain, _timeout);
                } else {
                  // 调用 DoT 查询函数
                  dotQuery(_queryUrl, _domain, _timeout);
                }
              },
              child: Text('Query'),
            ),
          ],
        ),
      ),
    );
  }


}