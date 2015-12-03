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
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var currGpa: UILabel!
    @IBOutlet weak var goalGpa: UILabel!
    @IBOutlet weak var gradDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        self.printUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function convert a numerical grade to letter grade
    func toLetterGrade(num:Double) -> String {
        [ "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
        [4.00, 3.67, 3.33, 3.00, 2.67, 2.33, 2.00, 1.67, 1.33, 1.00, 0.67, 0]
        var grade = "NA"
        if(num == 4) { grade = "A" }
        else if (num >= 3.67 && num < 4.00) { grade = "A-"}
        else if (num >= 3.33 && num < 3.67) { grade = "B+"}
        else if (num >= 3.0 && num < 3.33) { grade = "B"}
        else if (num >= 2.67 && num < 3.0) { grade = "B-"}
        else if (num >= 2.33 && num < 2.67) { grade = "C+"}
        else if (num >= 2.00 && num < 2.33) { grade = "C"}
        else if (num >= 1.67 && num < 2.00) { grade = "C-"}
        else if (num >= 1.33 && num < 1.67) { grade = "D+"}
        else if (num >= 1.00 && num < 1.33) { grade = "D"}
        else if (num >= 0.67 && num < 1.00) { grade = "D-"}
        else if (num >= 0 && num < 0.67) { grade = "F"}
        return grade
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daCourse", forIndexPath: indexPath) as! DegreeAuditTableViewCell
        
        // Set Status and Grade
        if( (currUserCourseTrack[indexPath.row]["currSched"] != nil) && (currUserCourseTrack[indexPath.row]["currSched"] as! Bool == true) ) {
            cell.courseStatus.text = "Status: Enrolled"
            cell.courseGrade.text = ""
            cell.contentView.backgroundColor = UIColor(red: 0, green: 43, blue: 255, alpha: 0.1)
        }
        else if( (currUserCourseTrack[indexPath.row]["currSched"] == nil) && (currUserCourseTrack[indexPath.row]["grade"] == nil) )  {
            cell.courseStatus.text = "Status: "
            cell.courseGrade.text = ""
            cell.contentView.backgroundColor = UIColor.clearColor()
        }
        else {
            cell.courseStatus.text = "Status: Taken"
            cell.courseGrade.text = toLetterGrade((currUserCourseTrack[indexPath.row]["grade"]) as! Double)
            cell.contentView.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 0.1)
        }
        
        for c in Courses {
            if(c == currUserCourseTrack[indexPath.row]["courses"] as! PFObject) {
                cell.courseId.text = String(c["courseId"])
                cell.courseDescription.text = String(c["courseName"])
                cell.courseCredit.text = "Credits: " + String(c["credits"])
                return cell
            }
        }
        
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
    
    func printUserInfo() {
        if(currUserProfile.count != 0) {
            let tmp = String(currUserProfile[0]["firstName"]) + ", " + String(currUserProfile[0]["lastName"])
            self.name.text = "Name: " + tmp
            self.currGpa.text = "GPA: " + String(currUserProfile[0]["currGPA"])
            self.goalGpa.text = "Goal GPA: " + String(currUserProfile[0]["goalGPA"])
            self.gradDate.text = "Graduation: " + String(currUserProfile[0]["expGraduation"])
        }
        else {
            self.name.text = "Name: "
            self.currGpa.text = "GPA: "
            self.goalGpa.text = "Goal GPA: "
            self.gradDate.text = "Graduation: TBA"
        }
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
