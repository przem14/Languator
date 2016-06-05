//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController, LessonDetailViewControllerDelegate {
    
    private let showLessonSegueId = "showLessonSegue"
    private let addLessonSegueId = "addLessonSegue"
    private let editLessonSegueId = "editLessonSegue"
    
    private let lessonCellId = "LessonCell"
    
    var dataModel: DataModel!
    private var lessons: [Lesson] {
        get { return dataModel.lessons }
        set { dataModel.lessons = newValue }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case showLessonSegueId: prepareForShowLessonSegue(segue, sender: sender)
        case addLessonSegueId: prepareForAddLessonSegue(segue)
        case editLessonSegueId: prepareForEditLessonSegue(segue, sender: sender)
        default: break
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(lessonCellId)!
        
        cell.textLabel!.text = lessons[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier(showLessonSegueId, sender: lessons[indexPath.row])
    }
    
    override func tableView(tableView: UITableView,
                            editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .Default, title: "Edit", handler: self.editRowAction)
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: self.deleteRowAction)
        
        editAction.backgroundColor = UIColor.blueColor()
        return [deleteAction, editAction]
    }
    
    
    // MARK: LessonDetailViewControllerDelegate
    
    func lessonDetailViewControllerDidCancel(controller: LessonDetailViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func lessonDetailViewController(controller: LessonDetailViewController, didAddLesson lesson: Lesson) {
        lessons.append(lesson)
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func lessonDetailViewController(controller: LessonDetailViewController, didEditLesson lesson: Lesson) {
        tableView.reloadData()
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Helpers
    
    private func editRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        let lessonToEdit = lessons[indexPath.row]
        performSegueWithIdentifier(editLessonSegueId, sender: lessonToEdit)
    }
    
    private func deleteRowAction(action: UITableViewRowAction, indexPath: NSIndexPath) {
        lessons.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    func prepareForShowLessonSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let lessonDetailViewController = segue.destinationViewController as! LessonViewController
        lessonDetailViewController.lesson = sender as! Lesson
    }
    
    func unwrapLessonDetailViewControllerFromSegue(segue: UIStoryboardSegue) -> LessonDetailViewController {
        let navigateController = segue.destinationViewController as! UINavigationController
        return navigateController.topViewController as! LessonDetailViewController
    }
    
    func prepareForAddLessonSegue(segue: UIStoryboardSegue) {
        let lessonDetailViewController = unwrapLessonDetailViewControllerFromSegue(segue)
        lessonDetailViewController.delegate = self
    }

    func prepareForEditLessonSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let lessonDetailViewController = unwrapLessonDetailViewControllerFromSegue(segue)
        lessonDetailViewController.delegate = self
        lessonDetailViewController.lessonToEdit = sender as? Lesson
    }
}
