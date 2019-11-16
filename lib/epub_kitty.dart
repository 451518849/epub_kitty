import 'dart:async';

import 'package:flutter/services.dart';

class EpubKitty{
  static const MethodChannel _channel =
      const MethodChannel('epub_kitty');

  static Future<String> open(String bookPath) async {
    Map<String,dynamic> agrs = {
      "bookPath":bookPath,
    };
    final String version = await _channel.invokeMethod('open',agrs);
    return version;
  }
}