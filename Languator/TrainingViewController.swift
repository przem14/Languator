//
//  TrainingViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {

    private let spellingTrainingSegue = "spellingTrainingSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == spellingTrainingSegue {
            let controller = segue.destinationViewController as! SpellingTrainingViewController
            controller.lesson = sender as! Lesson
        }
    }

}
