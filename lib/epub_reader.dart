import 'dart:async';

import 'package:flutter/services.dart';

class EpubReader {
  static const MethodChannel _channel =
      const MethodChannel('epub_reader');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> open(String title,String bookPath,int limitPage) async {
    Map<String,dynamic> agrs = {
      "bookPath":bookPath,
      "title":title,
      "limitPage":limitPage
    };
    final String version = await _channel.invokeMethod('open',agrs);
    return version;
  }
}
