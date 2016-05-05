//
//  WordDetailViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

protocol WordDetailViewControllerDelegate {
    func wordDetailViewControllerDidCancel(controller: WordDetailViewController)
    func wordDetailViewController(controller: WordDetailViewController, didAddWordItem item: WordItem)
}

class WordDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var foreignWordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate: WordDetailViewControllerDelegate?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        foreignWordTextField.becomeFirstResponder()
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if textField.restorationIdentifier == "foreignWordTextField" {
            doneButton.enabled = !newText.isEmpty && !translationTextField.text!.isEmpty
        } else {
            doneButton.enabled = !newText.isEmpty && !foreignWordTextField.text!.isEmpty
        }
        
        return true
    }
    
    
    // MARK: Actions
    
    @IBAction func didEndOnExitFromForeignWordTextField() {
        translationTextField.becomeFirstResponder()
    }
    
    @IBAction func didEndOnExitFromTranslationTextField(textField: UITextField) {
        guard !foreignWordTextField.text!.isEmpty else {
            return
        }
        addWordItem()
    }
    
    @IBAction func cancel() {
        delegate?.wordDetailViewControllerDidCancel(self)
    }
    
    @IBAction func addWordItem() {
        delegate?.wordDetailViewController(self, didAddWordItem: createWordItem())
    }
    
    
    // MARK: Helpers
    
    func createWordItem() -> WordItem {
        return WordItem(foreignWord: foreignWordTextField.text!, translation: translationTextField.text!)
    }
}
