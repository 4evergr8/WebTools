import 'dart:io';
import 'dart:async';

// 将 IP 地址转换为整数
int ipToInt(String ip) {
  List<int> parts = ip.split('.').map(int.parse).toList();
  return (parts[0] << 24) + (parts[1] << 16) + (parts[2] << 8) + parts[3];
}

// 将整数转换回 IP 地址
String intToIp(int ip) {
  return "${(ip >> 24) & 0xFF}.${(ip >> 16) & 0xFF}.${(ip >> 8) & 0xFF}.${ip & 0xFF}";
}

// 扫描函数
Future<void> scan(String startAddress, String endAddress, int timeoutMs) async {
  // 解析起始和结束 IP 地址
  int startIp = ipToInt(startAddress);
  int endIp = ipToInt(endAddress);

  // 确保起始 IP 小于或等于结束 IP
  if (startIp > endIp) {
    print('起始地址必须小于或等于结束地址');
    return;
  }

  // 扫描每个 IP 地址
  for (int ip = startIp; ip <= endIp; ip++) {
    String currentIp = intToIp(ip);

    // 尝试连接到当前 IP 地址
    try {
      // 使用 Socket 尝试连接
      await Socket.connect(currentIp, 80, timeout: Duration(milliseconds: timeoutMs));
      print('设备响应: $currentIp');
    } catch (e) {
      // 如果连接失败，不打印任何信息
    }
  }
}