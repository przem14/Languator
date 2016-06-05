//
//  WordItem.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class WordItem: NSObject, NSCoding {
    
    private let foreignWordKey = "foreignWord"
    private let translationKey = "translation"
    
    var foreignWord = ""
    var translation = ""
    
    
    init(foreignWord: String, translation: String) {
        self.foreignWord = foreignWord
        self.translation = translation
    }
    
    
    // MARK: NSCoding protocol
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        foreignWord = aDecoder.decodeObjectForKey(foreignWordKey) as! String
        translation = aDecoder.decodeObjectForKey(translationKey) as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(foreignWord, forKey: foreignWordKey)
        aCoder.encodeObject(translation, forKey: translationKey)
    }
}