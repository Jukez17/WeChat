import 'dart:io';

import 'package:wechat/models/Message.dart';

class VideoWrapper{
  final File file; //thumbnail for the video
  final VideoMessage videoMessage;
  VideoWrapper(this.file, this.videoMessage);
}