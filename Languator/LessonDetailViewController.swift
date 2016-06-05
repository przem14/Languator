//
//  LessonDetailViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

protocol LessonDetailViewControllerDelegate {
    func lessonDetailViewControllerDidCancel(controller: LessonDetailViewController)
    func lessonDetailViewController(controller: LessonDetailViewController, didAddLesson lesson: Lesson)
    func lessonDetailViewController(controller: LessonDetailViewController, didEditLesson lesson: Lesson)
}

class LessonDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private let editViewTitle = "Edit Lesson"
    
    var delegate: LessonDetailViewControllerDelegate?
    var lessonToEdit: Lesson?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareEditScreenIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        lessonNameTextField.becomeFirstResponder()
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = !newText.isEmpty
        return true
    }
    
    
    // MARK: Actions
    
    @IBAction func cancel() {
        delegate?.lessonDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let lesson = lessonToEdit {
            lesson.name = lessonNameTextField.text!
            delegate?.lessonDetailViewController(self, didEditLesson: lesson)
        } else {
            delegate?.lessonDetailViewController(self, didAddLesson: Lesson(name: lessonNameTextField.text!))
        }
    }
    
    
    // MARK: Helpers
    
    func prepareEditScreenIfNeeded() {
        guard let lesson = lessonToEdit else { return }
        
        title = editViewTitle
        lessonNameTextField.text = lesson.name
        doneButton.enabled = true
    }
}
