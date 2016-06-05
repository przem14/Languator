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
    func wordDetailViewController(controller: WordDetailViewController, didEditWordItem item: WordItem)
}

class WordDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var foreignWordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private let foreignWordTextFieldId = "foreignWordTextField"
    private let editViewTitle = "Edit Word"
    
    var delegate: WordDetailViewControllerDelegate?
    var itemToEdit: WordItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareEditScreenIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        foreignWordTextField.becomeFirstResponder()
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if textField.restorationIdentifier == foreignWordTextFieldId {
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
        guard !foreignWordTextField.text!.isEmpty else { return }
        
        addWordItem()
    }
    
    @IBAction func cancel() {
        delegate?.wordDetailViewControllerDidCancel(self)
    }
    
    @IBAction func addWordItem() {
        if let item = itemToEdit {
            updateItemToEdit()
            delegate?.wordDetailViewController(self, didEditWordItem: item)
        } else {
            delegate?.wordDetailViewController(self, didAddWordItem: createWordItem())
        }
    }
    
    
    // MARK: Helpers
    
    func prepareEditScreenIfNeeded() {
        if let item = itemToEdit {
            title = editViewTitle
            foreignWordTextField.text = item.foreignWord
            translationTextField.text = item.translation
            doneButton.enabled = true
        }
    }
    
    func createWordItem() -> WordItem {
        return WordItem(foreignWord: foreignWordTextField.text!, translation: translationTextField.text!)
    }
    
    func updateItemToEdit() {
        guard let item = itemToEdit else { return }
        
        item.foreignWord = foreignWordTextField.text!
        item.translation = translationTextField.text!
    }
}
