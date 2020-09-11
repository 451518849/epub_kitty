# epub_kitty_lib

![badge](https://img.shields.io/badge/build-passing-brightgreen)
![badge](https://img.shields.io/badge/version-0.1.7-orange)
![badge](https://img.shields.io/badge/platform-flutter-lightgrey)

![1](1.jpeg)

![2](2.jpeg)

epub_kitty_lib is an epub ebook reader that encapsulates the [folioreader](https://folioreader.github.io/FolioReaderKit/) framework.
  It supports iOS and android, but is customizable on iOS.
  It is very easy to use, you just need to set up the configuration file can open the ebook, very convenient.
  However, it is not yet highly customizable on android.
  But it has been able to meet daily needs.

## Install

  dependencies:
    epub_kitty_lib: ^1.0.0

## Simple Use

  first step

  ```dart
    ///
    // @identifier (android useless)
    // @themeColor
    // @scrollDirection (android useless)
    // @allowSharing (android useless)
    // @shouldHideNavigationOnTap (android useless)
    ///
    EpubKitty.setConfig("book", "#32a852","vertical",true, shouldHideNavigationOnTap:false);
```

  second step

 ```dart
  ///
  // @bookPath
  ///
  EpubReader.open('bookPath');
  // page channel used to monitor the current number of pages (only on the ios side)
  static const pageChannel = const EventChannel('com.epub_kitty_lib/page');
```

### Welcome TO PR

 Always open to PRs, so if you find a bug or a quick fix kindly share
