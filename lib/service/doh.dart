import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> dohQuery(String queryUrl, String domain, int timeoutMs) async {
  try {
    // 构造查询参数
    final query = base64Url.encode(utf8.encode(domain));
    final url = Uri.parse('$queryUrl?name=$query&type=ANY'); // 查询所有记录

    // 设置超时时间
    final response = await http.get(url).timeout(Duration(milliseconds: timeoutMs));

    if (response.statusCode == 200) {
      // 请求成功，返回解析结果
      final result = json.decode(response.body);
      return '请求成功。响应内容: ${json.encode(result)}';
    } else {
      // 请求失败，返回错误信息
      return '请求失败。状态码: ${response.statusCode}';
    }
  } catch (e) {
    // 捕获所有异常，返回错误信息
    return '请求失败。错误信息: $e';
  }
}