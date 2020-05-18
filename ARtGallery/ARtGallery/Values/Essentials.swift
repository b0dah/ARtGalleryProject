//
//  Essentials.swift
//  ARtGallery
//
//  Created by Иван Романов on 18.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Essentials {
    
    static func prettifyString(string: String, span: Int) -> String {
        var result = "\t"
        var count = 0
        
        string.map {
            if $0.isWhitespace {
                if count == span - 1 {
                    result.append("\n")
                    count = 0
                } else {
                    count += 1
                    result.append($0)
                }
            }
            else {
                result.append($0)
            }
        }
        return result
    }
}
