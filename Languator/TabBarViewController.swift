//
//  TabBarViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let learningViewControllerArrayIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.startLesson),
                                                         name: kStartLessonNotification,
                                                         object: nil)
    }
    
    
    // Helpers
    
    func startLesson() {
        selectedIndex = learningViewControllerArrayIndex
    }
}
