//
//  textModel.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import Foundation

struct TextModel {
    
    var text: String
    
    public static func makeMockModel() -> [String] {
        
        var model = [String]()
        
        for i in 1 ... 25 {
            model.append("test \(i) more more more")
        }
        
        return model
    }
}
