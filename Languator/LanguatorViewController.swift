//
//  LanguatorViewController.swift
//  Languator
//
//  Created by Przemysław Wawrzyniak on 04.06.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import UIKit

class LanguatorViewController: UITableViewController {
    
    var dataModel: DataModel!
    private var lessons: [Lesson] {
        get { return dataModel.lessons }
        set { dataModel.lessons = newValue }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lessons = [Lesson(name: "Lesson#1")]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLessonSegue" {
            let controller = segue.destinationViewController as! LessonViewController
            controller.lesson = sender as! Lesson
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LessonCell")!
        
        cell.textLabel!.text = lessons[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("showLessonSegue", sender: lessons[indexPath.row])
    }
}
