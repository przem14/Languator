//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController, WordDetailViewControllerDelegate {

    var words: [WordItem]
    
    
    required init?(coder aDecoder: NSCoder) {
        words = [WordItem]()
        
        super.init(coder: aDecoder)
        
        words.append(WordItem(foreignWord: "cat", translation: "kot"))
        words.append(WordItem(foreignWord: "dog", translation: "pies"))
        words.append(WordItem(foreignWord: "horse", translation: "koń"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WordDetailSegue" {
            let navigateController = segue.destinationViewController as! UINavigationController
            let wordDetailViewController = navigateController.topViewController as! WordDetailViewController
            wordDetailViewController.delegate = self
        }
    }
    
    
    // MARK: UITableViewController
    
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
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        words.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    func prepareCell(cell: UITableViewCell, row: Int) {
        let wordItem = words[row]
        cell.textLabel!.text = wordItem.foreignWord
        cell.detailTextLabel!.text = wordItem.translation
    }
    
    
    // MARK: WordDetailViewControllerDelegate
    
    func wordDetailViewControllerDidCancel(controller: WordDetailViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func wordDetailViewController(controller: WordDetailViewController, didAddWordItem item: WordItem) {
        words.append(item)
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

