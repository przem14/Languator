//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordCell")!
        
        cell.textLabel!.text = "Word"
        cell.detailTextLabel!.text = "Translation"
        return cell
    }
}

