//
//  CourseAvailabilityViewController.swift
//  Gator Aid
//
//  Created by Charles,Kinderley on 12/2/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class CourseAvailabilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // UI variables declarations
    @IBOutlet var Menu:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    // Define each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allCoursesId", forIndexPath: indexPath) as! CourseAvbleTableViewCell
        cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        
        // Find when course is offered
        var offer = ""
        if(Courses[indexPath.row]["offerFall"] as! Bool == true) {
            offer = "Offered: Fall "
        }
        if(Courses[indexPath.row]["offerSpring"] as! Bool == true) {
            offer = offer + "| Spring "
        }
        if(Courses[indexPath.row]["offerSummer"] as! Bool == true) {
            offer = offer + "| Summer "
        }
        
        //Update cell with information
        cell.courseId.text = String(Courses[indexPath.row]["courseId"])
        cell.courseDesc.text = String(Courses[indexPath.row]["courseName"])
        cell.credits.text = "Credits: " + String(Courses[indexPath.row]["credits"])
        cell.offered.text = offer
        
        return cell
    }
    
    // return the number of rows in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Courses.count
    }
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
}
