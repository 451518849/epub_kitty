import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const pageChannel =
      const EventChannel('com.xiaofwang.epub_kitty/page');

  @override
  void initState() {
    super.initState();

    // pageChannel.receiveBroadcastStream('com.xiaofwang.epub_kitty/page').listen(
    //     (Object event) {
    //   print('page:$event');
    // }, onError: null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () async {
              Directory appDocDir = await getApplicationDocumentsDirectory();
              print('$appDocDir');

              String iosBookPath = '${appDocDir.path}/epub/4.epub';
              String androidBookPath =
                  'file:///android_asset/PhysicsSyllabus.epub';
              EpubKitty.setConfig("iosBook", "#32a852", "vertical", true);
              EpubKitty.open(iosBookPath);
            },
            child: Container(
              child: Text('open epub'),
            ),
          ),
        ),
      ),
    );
  }
}

//path:file:///var/mobile/Containers/Data/Application/BF0BEEFE-31BC-4989-B779-6517EE275336/Documents/3.epub/OEBPS/cover.xhtml