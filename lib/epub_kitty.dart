import 'package:flutter/services.dart';

class EpubKitty{
  static const MethodChannel _channel =
      const MethodChannel('epub_kitty');

  static void setConfig(String identifier,String themeColor,String scrollDirection,bool allowSharing) async {
    Map<String,dynamic> agrs = {
      "identifier":identifier,
      "themeColor":themeColor,
      "scrollDirection":scrollDirection,
      "allowSharing":allowSharing,

    };
    await _channel.invokeMethod('setConfig',agrs);
  }
  static void open(String bookPath) async {
    Map<String,dynamic> agrs = {
      "bookPath":bookPath,
    };
    await _channel.invokeMethod('open',agrs);
  }
}
