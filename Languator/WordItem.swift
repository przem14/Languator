//
//  WordItem.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class WordItem {
    var foreignWord = ""
    var translation = ""
    
    init(foreignWord: String, translation: String) {
        self.foreignWord = foreignWord
        self.translation = translation
    }
}