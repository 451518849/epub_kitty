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
  static const pageChannel = const EventChannel('com.xiaofwang.epub_kitty/page');

  @override
  void initState() {
    super.initState();
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
              Directory appDocDir = await getTemporaryDirectory();
              print(appDocDir.path);

              String iosBookPath = '${appDocDir.path}/3.epub';
              String androidBookPath = 'file:///android_asset/PhysicsSyllabus.epub';
              EpubKitty.open(iosBookPath);

              pageChannel.receiveBroadcastStream().listen((Object event) {
                print('page:$event');
              }, onError: null);
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
