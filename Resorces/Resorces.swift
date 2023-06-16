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
        
        static var background = UIColor(hexString: "#F8F9F9")
        static var separator = UIColor(hexString: "#E8ECEF")
        static var titleGray = UIColor(hexString: "#545C77")
    }
    enum Font {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "helvetica", size: size) ?? UIFont()
        }
    }
    enum Strings {
        
    }
}
