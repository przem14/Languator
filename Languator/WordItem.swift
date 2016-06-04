//
//  WordItem.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class WordItem: NSObject, NSCoding {
    var foreignWord = ""
    var translation = ""
    
    init(foreignWord: String, translation: String) {
        self.foreignWord = foreignWord
        self.translation = translation
    }
    
    
    // MARK: NSCoding protocol
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        foreignWord = aDecoder.decodeObjectForKey("foreignWord") as! String
        translation = aDecoder.decodeObjectForKey("translation") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(foreignWord, forKey: "foreignWord")
        aCoder.encodeObject(translation, forKey: "translation")
    }
}