//
//  LessonViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.05.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LessonViewController: UITableViewController, WordDetailViewControllerDelegate {

    private let addWordSegueId = "addWordSegue"
    private let editWordSegueId = "editWordSegue"
    
    private let wordCellId = "WordCell"
    private let startLessonCellId = "StartLessonCell"
    
    private let numberOfSections = 2
    private let startLessonCell = (section: 0, numberOfRows: 1)
    
    var lesson: Lesson!
    private var wordItems: [WordItem] {
        get { return lesson.wordItems }
        set { lesson.wordItems = newValue }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = lesson.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case addWordSegueId: prepareForAddWordSegue(segue)
        case editWordSegueId: prepareForEditWordSegue(segue, sender: sender)
        default: break
        }
    }
    
    
    // MARK: UITableViewController
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == startLessonCell.section {
            return startLessonCell.numberOfRows
        }
        return wordItems.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == startLessonCell.section {
            return tableView.dequeueReusableCellWithIdentifier(startLessonCellId)!
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(wordCellId)!
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
    }
    
    func wordDetailViewController(controller: WordDetailViewController, didAddWordItem item: WordItem) {
        wordItems.append(item)
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Helpers
    
    private func editRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        let itemToEdit = wordItems[indexPath.row]
        performSegueWithIdentifier(editWordSegueId, sender: itemToEdit)
    }
    
    private func deleteRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        wordItems.removeAtIndex(indexPath.row)
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

