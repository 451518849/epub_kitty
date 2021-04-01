# epub_kitty_lib

![badge](https://img.shields.io/badge/build-passing-brightgreen)
![badge](https://img.shields.io/badge/version-1.0.2-green)
![badge](https://img.shields.io/badge/platform-flutter-blue)

![1](1.jpeg)

![2](2.jpeg)

epub_kitty_lib is an epub ebook reader that encapsulates the [folioreader](https://folioreader.github.io/FolioReaderKit/) framework.
  It supports iOS and android, but is customizable on iOS.
  It is very easy to use, you just need to set up the configuration file can open the ebook, very convenient.
  However, it is not yet highly customizable on android.
  But it has been able to meet daily needs.

## Install

  ```yaml
  dependencies:
    epub_kitty_lib: ^2.0.0
  ```

## Beraking Changes

 All paramaters have been moved to name parameters post migration to null-saftey

  ```dart
    
     EpubKitty.setConfig(
        identifier: "iosBook", // Not useful on android 
        themeColor: Color(0xff32a852),
        scrollDirection: EKScrollDirection.horizontal, // Not useful on android 
        allowSharing: true,
        shouldHideNavigationOnTap: false,  // Not useful on android 
    );
```

## Finally 

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
