//
//  DataModel.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import Foundation

class DataModel {
    
    private let lessonsPlistFileName = "Lessons.plist"
    private let lessonsKey = "Lessons"
    
    var lessons = [Lesson]()
    
    
    init() {
        loadWordItems()
    }
    
    // MARK: Persisting Data
    
    func documentsDirectoryPath() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths.first!
    }
    
    func dataFilePath() -> String {
        return documentsDirectoryPath().stringByAppendingPathComponent(lessonsPlistFileName)
    }
    
    func encodeLessons(data: NSMutableData) {
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(lessons, forKey: lessonsKey)
        archiver.finishEncoding()
    }
    
    func decodeLessons(data: NSData) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        lessons = unarchiver.decodeObjectForKey(lessonsKey) as! [Lesson]
        unarchiver.finishDecoding()
    }
    
    func saveLessons() {
        let data = NSMutableData()
        
        encodeLessons(data)
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadWordItems() {
        guard NSFileManager.defaultManager().fileExistsAtPath(dataFilePath()) else { return }
        guard let data = NSData(contentsOfFile: dataFilePath()) else { return }
        
        decodeLessons(data)
    }
}