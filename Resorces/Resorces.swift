//
//  Resorces.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

enum Resorces {
    enum Colors {
        static var active = UIColor(hexString: "#437BFE")
        static var inactive = UIColor(hexString: "#929DA5")
        
        static var background = UIColor.systemBackground
        static var backgroundGray = UIColor.systemGray5
        static var settingsBlocksBackground = UIColor.systemGroupedBackground
        static var separator = UIColor.systemGray3
        
        static var titleLabel = UIColor.label
        static var titleSecondaryLabel = UIColor.secondaryLabel
    }
    enum Font {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "helvetica", size: size) ?? UIFont()
        }
    }
    enum Authors {
        case user
        case assistant
    }
    
}
