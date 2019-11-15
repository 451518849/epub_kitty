import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:epub_reader/epub_reader.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const pageChannel = const EventChannel('com.xiaofwang.epub_reader/page');

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
              Directory appDocDir = await getApplicationDocumentsDirectory();
              print(appDocDir.path);

              String iosBookPath = '${appDocDir.path}/3.epub';
              String androidBookPath = 'file:///android_asset/PhysicsSyllabus.epub';
              EpubReader.open(androidBookPath);

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
