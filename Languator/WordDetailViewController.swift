//
//  WordDetailViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

protocol WordDetailViewControllerDelegate {
    func didCancelWordDetailViewController(controller: WordDetailViewController)
}

class WordDetailViewController: UITableViewController {
    @IBOutlet weak var foreignWordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    
    var delegate: WordDetailViewControllerDelegate?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        foreignWordTextField.becomeFirstResponder()
    }
    
    
    // MARK: Actions
    
    @IBAction func didEndOnExitFromForeignWordTextField() {
        translationTextField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.didCancelWordDetailViewController(self)
    }
}
