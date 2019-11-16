# epub_kitty

![](https://img.shields.io/badge/build-passing-brightgreen)
![](https://img.shields.io/badge/version-0.0.3-orange)
![](https://img.shields.io/badge/platform-flutter-lightgrey)


![](1.jpeg)
![](2.jpeg)


epub_kitty是款epub电子书阅读器，是对开源框架[folioreader](https://folioreader.github.io/FolioReaderKit/)的封装。
[epub_kitty 0.0.3](https://pub.dev/packages/epub_kitty)

## 安装
	dependencies:
	  epub_kitty: ^0.0.3

## 一行代码即可
   
	   /**
	   * @bookPath 电子书文档路径
	   */
	EpubReader.open('bookPath');
	
	// page channel 用来监听当前页数（仅限ios端）
	  static const pageChannel = const EventChannel('com.xiaofwang.epub_reader/page');

	
