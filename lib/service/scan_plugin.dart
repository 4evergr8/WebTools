import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<String>> processDirectory(String targetFolderName) async {
  List<String> validFolders = [];

  try {
    // 获取应用的文档目录
    final appDir = await getApplicationDocumentsDirectory();
    final targetPath = '${appDir.path}/$targetFolderName';

    // 检查目标目录是否存在
    final targetDir = Directory(targetPath);
    if (!await targetDir.exists()) {
      print('Target directory does not exist: $targetPath');
      return validFolders;
    }

    // 获取目标目录下的所有文件和文件夹
    final entities = await targetDir.list().toList();

    for (final entity in entities) {
      if (entity is Directory) {
        // 检查文件夹内是否包含 config.yaml
        final configFilePath = '${entity.path}/config.yaml';
        final configFile = File(configFilePath);
        if (await configFile.exists()) {
          // 如果包含 config.yaml，将文件夹名称加入数组
          validFolders.add(entity.path.split('/').last);
        } else {
          // 如果不包含 config.yaml，删除该文件夹
          await entity.delete(recursive: true);
        }
      } else if (entity is File) {
        // 如果是文件，删除文件
        await entity.delete();
      }
    }
  } catch (e) {
    print('Failed to process directory: $e');
  }

  return validFolders;
}