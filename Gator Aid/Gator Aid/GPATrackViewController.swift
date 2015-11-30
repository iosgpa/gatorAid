//
//  GPATrackViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/23/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class GPATrackViewController: UIViewController, UIPickerViewDelegate, UITableViewDataSource {

    // UI Variable declarations
    @IBOutlet weak var Menu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daCourse", forIndexPath: indexPath) as! DegreeAuditTableViewCell
        
        // Set Status and Grade
        if( (currUserCourseTrack[indexPath.row]["currSched"] != nil) && (currUserCourseTrack[indexPath.row]["currSched"] as! Bool == true) ) {
            cell.courseStatus.text = "Status: Enrolled"
            cell.courseGrade.text = ""
        }
        else if( (currUserCourseTrack[indexPath.row]["grade"]) == nil ) {
            cell.courseStatus.text = "Status: "
            cell.courseGrade.text = ""
        }
        else {
            cell.courseStatus.text = "Status: Taken"
            cell.courseGrade.text = String(currUserCourseTrack[indexPath.row]["grade"])
        }
        
        
        for c in Courses {
            if(c == currUserCourseTrack[indexPath.row]["courses"] as! PFObject) {
                cell.courseId.text = String(c["courseId"])
                cell.courseDescription.text = String(c["courseName"])
                cell.courseCredit.text = String(c["credits"])
                
                cell.contentView.backgroundColor = UIColor.clearColor();
                cell.backgroundColor = UIColor.clearColor()
                return cell
            }
        }
        
        cell.contentView.backgroundColor = UIColor.clearColor();
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currUserCourseTrack.count
    }

    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
