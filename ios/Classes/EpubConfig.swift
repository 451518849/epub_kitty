//
//  EpubConfig.swift
//  AEXML
//
//  Created by 小发工作室 on 2019/11/21.
//

import UIKit

class EpubConfig: NSObject {
    
    open var config: FolioReaderConfig!
    
    open var tintColor: UIColor = UIColor.init(rgba:"#fdd82c")
    open var allowSharing: Bool = false
    open var scrollDirection: FolioReaderScrollDirection = FolioReaderScrollDirection.vertical
    
    init(Identifier: String,tintColor: String, allowSharing: Bool,scrollDirection: String) {
        self.config = FolioReaderConfig(withIdentifier: Identifier)
        self.tintColor = UIColor.init(rgba: tintColor)
        self.allowSharing = allowSharing
        if scrollDirection == "vertical"{
            self.config.scrollDirection = FolioReaderScrollDirection.vertical
        }else {
            self.config.scrollDirection = FolioReaderScrollDirection.horizontal
        }
        super.init()
        
        self.readerConfiguration()

    }
    
    private func readerConfiguration() {
        self.config.shouldHideNavigationOnTap = true
        self.config.scrollDirection = self.scrollDirection
        self.config.enableTTS = false
        self.config.displayTitle = true
        self.config.allowSharing = self.allowSharing
        self.config.tintColor = self.tintColor
        self.config.canChangeFontStyle = false
        // Custom sharing quote background
        self.config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            self.config.quoteCustomBackgrounds.append(customImageQuote)
              }

        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        self.config.quoteCustomBackgrounds.append(customQuote)
    }
      
}
