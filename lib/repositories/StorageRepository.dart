import 'dart:io';

import 'package:wechat/providers/StorageProvider.dart';

class StorageRepository{
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadFile(File file, String path) => storageProvider.uploadFile(file, path);
}