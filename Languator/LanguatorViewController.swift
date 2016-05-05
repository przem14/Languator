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
        switch segue.identifier! {
        case "addWordSegue":
            prepareForAddWordSegue(segue)
        case "editWordSegue":
            prepareForEditWordSegue(segue, sender: sender)
        default:
            break
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
                            editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .Default, title: "Edit", handler: self.editRowAction)
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: self.deleteRowAction)
        
        editAction.backgroundColor = UIColor.blueColor()
        return [deleteAction, editAction]
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
    
    func wordDetailViewController(controller: WordDetailViewController, didEditWordItem item: WordItem) {
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func wordDetailViewController(controller: WordDetailViewController, didAddWordItem item: WordItem) {
        words.append(item)
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Helpers
    
    private func editRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        let itemToEdit = words[indexPath.row]
        performSegueWithIdentifier("editWordSegue", sender: itemToEdit)
    }
    
    private func deleteRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        words.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    func unwrapWordDetailControllerFromSegue(segue: UIStoryboardSegue) -> WordDetailViewController {
        let navigateController = segue.destinationViewController as! UINavigationController
        return navigateController.topViewController as! WordDetailViewController
    }
    
    func prepareForAddWordSegue(segue: UIStoryboardSegue) {
        let wordDetailViewController = unwrapWordDetailControllerFromSegue(segue)
        wordDetailViewController.delegate = self
    }
    
    func prepareForEditWordSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wordDetailViewController = unwrapWordDetailControllerFromSegue(segue)
        wordDetailViewController.delegate = self
        wordDetailViewController.itemToEdit = (sender as! WordItem)
    }
}

