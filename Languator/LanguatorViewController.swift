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
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        lessons.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.reloadData()
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
        
    }
    
    
    // MARK: Helpers
    
    func prepareForShowLessonSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! LessonViewController
        controller.lesson = sender as! Lesson
    }
    
    func prepareForAddLessonSegue(segue: UIStoryboardSegue) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! LessonDetailViewController
        controller.delegate = self
    }
}
