//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController {

    var words: [(foreign: String, translation: String)] = [("cat", "kot"),
                                                           ("dog", "pies"),
                                                           ("horse", "koń")]
    
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
        return words.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordCell")!
        
        prepareCell(cell, row: indexPath.row)
        return cell
    }
    
    func prepareCell(cell: UITableViewCell, row: Int) {
        let word = words[row]
        cell.textLabel!.text = word.foreign
        cell.detailTextLabel!.text = word.translation
    }
}

