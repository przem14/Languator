//
//  Lesson.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class Lesson: NSObject, NSCoding {
    var name = ""
    var wordItems = [WordItem]()
    
    
    init(name: String) {
        self.name = name
    }
    
    
    // MARK: NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        wordItems = aDecoder.decodeObjectForKey("wordItems") as! [WordItem]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(wordItems, forKey: "wordItems")
    }
}
