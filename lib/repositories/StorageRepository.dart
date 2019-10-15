import 'dart:io';

import 'package:wechat/providers/StorageProvider.dart';
import 'package:wechat/repositories/BaseRepository.dart';

class StorageRepository extends BaseRepository{
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadFile(File file, String path) => storageProvider.uploadFile(file, path);

  @override
  void dispose() {
    storageProvider.dispose();
  }
}