// file_extractor.dart
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';


Future<void> extractFile(File file, String targetFolderName) async {
  try {
    // 读取文件内容
    final bytes = file.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    // 获取应用的文档目录
    final appDir = await getApplicationDocumentsDirectory();
    final targetFolderPath = '${appDir.path}/$targetFolderName';

    // 创建目标文件夹
    final targetFolder = Directory(targetFolderPath);
    if (!await targetFolder.exists()) {
      await targetFolder.create(recursive: true);
    }

    // 解压文件到目标文件夹
    for (final archiveFile in archive) {
      final filePath = '$targetFolderPath/${archiveFile.name}';
      if (archiveFile.name.endsWith('/')) {
        // 如果是目录，创建目录
        Directory(filePath).createSync(recursive: true);
      } else {
        // 如果是文件，写入文件
        File(filePath).writeAsBytesSync(archiveFile.content as List<int>);
      }
    }
  } catch (e) {
    rethrow; // 重新抛出异常，以便在调用处捕获
  }
}