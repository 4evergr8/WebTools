import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

Future<String> dotQuery(String queryUrl, String domain, int timeoutMs) async {
  try {
    // 解析 DoT 服务器地址
    final server = Uri.parse(queryUrl);
    final socket = await SecureSocket.connect(
      server.host,
      server.port ?? 853, // 默认端口为 853
      onBadCertificate: (cert) => true, // 忽略证书验证（仅用于测试）
    ).timeout(Duration(milliseconds: timeoutMs));

    // 构造 DNS 查询报文（查询类型为 ANY）
    final queryId = _generateRandomId(); // 随机生成查询 ID
    final query = _buildDnsQuery(queryId, domain, type: 'ANY');

    // 发送查询
    socket.add(query);

    // 接收响应
    final response = await socket.first.timeout(Duration(milliseconds: timeoutMs));
    final result = utf8.decode(response);

    socket.close();
    return '请求成功。响应内容: $result';
  } catch (e) {
    return '请求失败。错误信息: $e';
  }
}

// 生成随机查询 ID（2 字节）
int _generateRandomId() {
  final random = Random();
  return random.nextInt(65536); // 0 到 65535
}

// 构造 DNS 查询报文
Uint8List _buildDnsQuery(int queryId, String domain, {String type = 'ANY'}) {
  final transactionId = queryId.toRadixString(16).padLeft(4, '0');
  final flags = '0100'; // 标准查询
  final questions = '0001'; // 一个问题
  final answerRRs = '0000'; // 无回答
  final authorityRRs = '0000'; // 无权威记录
  final additionalRRs = '0000'; // 无附加记录

  // 构造域名部分
  final domainParts = domain.split('.');
  final domainBytes = domainParts.map((part) {
    final length = part.length.toRadixString(16).padLeft(2, '0');
    final name = part.codeUnits.map((unit) => unit.toRadixString(16).padLeft(2, '0')).join();
    return '$length$name';
  }).join() + '00'; // 添加域名结束标志

  // 查询类型：ANY
  final typeHex = '00ff';
  // 查询类别：IN
  final classType = '0001';

  // 构造完整的查询报文
  final queryHex = '$transactionId$flags$questions$answerRRs$authorityRRs$additionalRRs$domainBytes$typeHex$classType';

  // 将十六进制字符串转换为字节数组
  final queryBytes = Uint8List(queryHex.length ~/ 2);
  for (int i = 0; i < queryHex.length; i += 2) {
    queryBytes[i ~/ 2] = int.parse(queryHex.substring(i, i + 2), radix: 16);
  }

  return queryBytes;
}