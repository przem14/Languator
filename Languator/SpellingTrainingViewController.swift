//
//  SpellingTrainingViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 05.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class SpellingTrainingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lessonNameLabel: UILabel!
    @IBOutlet weak var foreignWordLabel: UILabel!
    @IBOutlet weak var translationTextField: UITextField!
    
    var lesson: Lesson!
    var actualWordIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessonNameLabel.text = lesson.name
        foreignWordLabel.text = lesson.wordItems[actualWordIndex].foreignWord
    }
    
    override func viewWillAppear(animated: Bool) {
        translationTextField.becomeFirstResponder()
    }

    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkResult()
        
        return true
    }
    
    
    // MARK: Helpers
    
    func checkResult() {
        if translationTextField.text!.lowercaseString == lesson.wordItems[actualWordIndex].translation.lowercaseString {
            actualWordIndex += 1
            guard actualWordIndex != lesson.wordItems.count else {
                navigationController?.popToRootViewControllerAnimated(true)
                return
            }
            
            foreignWordLabel.text = lesson.wordItems[actualWordIndex].foreignWord
            translationTextField.text = nil
        }
    }

}
