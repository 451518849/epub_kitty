import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epub_kitty_lib/epub_kitty_lib.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('EpubKitty Example app'),
        ),
        body: Center(
          child: CupertinoButton(
            color: Colors.blue,
            onPressed: () async {
              Directory appDocDir = await getApplicationDocumentsDirectory();
              print('$appDocDir');

              String androidBookPath =
                  'file:///android_asset/PhysicsSyllabus.epub';
              EpubKitty.setConfig(
                identifier: "iosBook",
                themeColor: Color(0xff32a852),
                scrollDirection: EKScrollDirection.horizontal,
                allowSharing: true,
                shouldHideNavigationOnTap: false,
              );

              EpubKitty.open(androidBookPath);
            },
            child: Text('Open Epub',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}

//path:file:///var/mobile/Containers/Data/Application/BF0BEEFE-31BC-4989-B779-6517EE275336/Documents/3.epub/OEBPS/cover.xhtml
