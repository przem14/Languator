//
//  DataModel.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class DataModel {
    var wordItems = [WordItem]()
    
    
    init() {
        loadWordItems()
    }
    
    // MARK: Persisting Data
    
    func documentsDirectoryPath() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths.first!
    }
    
    func dataFilePath() -> String {
        return documentsDirectoryPath().stringByAppendingPathComponent("WordItems.plist")
    }
    
    func encodeWordItems(data: NSMutableData) {
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(wordItems, forKey: "WordItems")
        archiver.finishEncoding()
    }
    
    func decodeWordItems(data: NSData) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        wordItems = unarchiver.decodeObjectForKey("WordItems") as! [WordItem]
        unarchiver.finishDecoding()
    }
    
    func saveWordItems() {
        let data = NSMutableData()
        
        encodeWordItems(data)
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadWordItems() {
        guard NSFileManager.defaultManager().fileExistsAtPath(dataFilePath()) else { return }
        guard let data = NSData(contentsOfFile: dataFilePath()) else { return }
        
        decodeWordItems(data)
    }
}