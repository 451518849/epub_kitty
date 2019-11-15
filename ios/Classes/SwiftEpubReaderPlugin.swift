import Flutter
import UIKit
import RealmSwift
import Realm



public class SwiftEpubReaderPlugin: NSObject, FlutterPlugin,FolioReaderPageDelegate,FlutterStreamHandler {

    let folioReader = FolioReader()
    static var pageResult: FlutterResult? = nil
    static var pageChannel:FlutterEventChannel? = nil
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "epub_reader", binaryMessenger: registrar.messenger())
    let instance = SwiftEpubReaderPlugin()
    
    pageChannel = FlutterEventChannel.init(name: "com.xiaofwang.epub_reader/page",
                                binaryMessenger: registrar.messenger());
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    

    switch call.method {
    case "open":
        setPageHandler()
        let arguments = call.arguments as![String:Any]
        let bookPath = arguments["bookPath"] as! String
        self.open(epubPath: bookPath)

        break
    case "close":
        self.close()
        break
    default:
        break
    }
//    result("iOS " + UIDevice.current.systemVersion)
  }
    
    private func setPageHandler(){
        SwiftEpubReaderPlugin.pageChannel?.setStreamHandler(self)

    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftEpubReaderPlugin.pageResult = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    private func readerConfiguration(Identifier: String) -> FolioReaderConfig {
            let config = FolioReaderConfig(withIdentifier: Identifier)
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

        let Identifier = epubPath.split(separator: "/").last!
        print("epubPath:"+epubPath)
        let readerVc = UIApplication.shared.keyWindow!.rootViewController ?? UIViewController()
        
        let readerConfiguration = self.readerConfiguration(Identifier: String(Identifier))
        
        folioReader.presentReader(parentViewController: readerVc, withEpubPath: epubPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
        folioReader.readerCenter?.pageDelegate = self
    }

    public func pageWillLoad(_ page: FolioReaderPage) {
        
        print("page.pageNumber:"+String(page.pageNumber))

        if (SwiftEpubReaderPlugin.pageResult != nil){
            SwiftEpubReaderPlugin.pageResult!(String(page.pageNumber))
        }

    }
    
    private func close(){
        folioReader.readerContainer?.dismiss(animated: true, completion: nil)
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
