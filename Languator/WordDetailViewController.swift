//
//  WordDetailViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class WordDetailViewController: UITableViewController {
    @IBOutlet weak var foreignWordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        foreignWordTextField.becomeFirstResponder()
    }
    
    @IBAction func didEndOnExitFromForeignWordTextField() {
        translationTextField.becomeFirstResponder()
    }
}
