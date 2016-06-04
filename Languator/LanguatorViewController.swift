//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController, WordDetailViewControllerDelegate {

    var wordItems: [WordItem]
    
    
    required init?(coder aDecoder: NSCoder) {
        wordItems = [WordItem]()
        
        super.init(coder: aDecoder)
        
        loadWordItems()
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
    
    
    // MARK: Persisting Data
    
    func documentsDirectoryPath() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths.first!
    }
    
    func dataFilePath() -> String {
        return documentsDirectoryPath().stringByAppendingPathComponent("WordItems.plist")
    }
    
    func encodeWordItems(data: NSMutableData) {
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(wordItems, forKey: "WordItems")
        archiver.finishEncoding()
    }
    
    func decodeWordItems(data: NSData) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        wordItems = unarchiver.decodeObjectForKey("WordItems") as! [WordItem]
        unarchiver.finishDecoding()
    }
    
    func saveWordItems() {
        let data = NSMutableData()
        
        encodeWordItems(data)
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadWordItems() {
        guard NSFileManager.defaultManager().fileExistsAtPath(dataFilePath()) else { return }
        guard let data = NSData(contentsOfFile: dataFilePath()) else { return }
        
        decodeWordItems(data)
    }
    
    
    // MARK: UITableViewController
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordItems.count
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
        let wordItem = wordItems[row]
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
        
        saveWordItems()
    }
    
    func wordDetailViewController(controller: WordDetailViewController, didAddWordItem item: WordItem) {
        wordItems.append(item)
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        saveWordItems()
    }
    
    
    // MARK: Helpers
    
    private func editRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        let itemToEdit = wordItems[indexPath.row]
        performSegueWithIdentifier("editWordSegue", sender: itemToEdit)
    }
    
    private func deleteRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        wordItems.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
        
        saveWordItems()
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

