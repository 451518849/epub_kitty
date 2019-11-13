import Flutter
import UIKit
import RealmSwift
import Realm

var pageResult: FlutterResult? = nil


public class SwiftEpubReaderPlugin: NSObject, FlutterPlugin,FolioReaderPageDelegate {
    var limitPage = 0
    let folioReader = FolioReader()
    var bookTitle = ""
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "epub_reader", binaryMessenger: registrar.messenger())
    let instance = SwiftEpubReaderPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "open":
        let arguments = call.arguments as![String:Any]
        pageResult = result
        bookTitle = arguments["title"] as! String
        let bookPath = arguments["bookPath"] as! String

        self.limitPage = arguments["limitPage"] as! Int
        
//        let bookPath = Bundle.main.path(forResource: "2", ofType: "epub")!
        self.open(epubPath: bookPath)
        break
    default:
        break
    }
//    result("iOS " + UIDevice.current.systemVersion)
  }

    
    private func readerConfiguration() -> FolioReaderConfig {
            let config = FolioReaderConfig(withIdentifier: "READER_ONE")
            config.shouldHideNavigationOnTap = true
            config.scrollDirection = FolioReaderScrollDirection.vertical
            config.enableTTS = false
            config.displayTitle = true
            config.allowSharing = false
            config.tintColor = UIColor.init(rgb:0xfffdd82c);
            // Custom sharing quote background
            config.quoteCustomBackgrounds = []
            if let image = UIImage(named: "demo-bg") {
                let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
                config.quoteCustomBackgrounds.append(customImageQuote)
            }

            let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
            let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
            let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
            config.quoteCustomBackgrounds.append(customQuote)

            return config
        }
    
    fileprivate func open(epubPath: String) {
         if epubPath == "" {
            return
        }

        print("epubPath:"+epubPath)
        let readerVc = UIApplication.shared.keyWindow!.rootViewController ?? UIViewController()

        let readerConfiguration = self.readerConfiguration()
        
        folioReader.presentReader(parentViewController: readerVc, withEpubPath: epubPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
        folioReader.readerCenter?.pageDelegate = self
    }

    public func pageWillLoad(_ page: FolioReaderPage) {
        print("page:" + String(page.pageNumber))
        if self.limitPage != 0 && self.limitPage == page.pageNumber{
            folioReader.readerContainer?.dismiss(animated: true, completion: nil)
            folioReader.readerContainer?.dismiss()
        }
    }

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
