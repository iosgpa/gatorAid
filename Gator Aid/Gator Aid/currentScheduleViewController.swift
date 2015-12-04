//
//  currentScheduleViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 12/3/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class currentScheduleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var Menu: UIBarButtonItem!
    var pickCourse = currUserCourseTrack
    var selectedCourseIndex: Int = 0
    @IBOutlet weak var succMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        var cPickerView = UIPickerView()
        cPickerView.delegate = self
        course.inputView = cPickerView
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickCourse.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickCourse[row]["courses"]["courseName"] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        course.text = pickCourse[row]["courses"]["courseName"] as? String
        selectedCourseIndex = row
        self.view.endEditing(true)
    }
    
    func computeUserGpa() {
        var creditsEarned = 0.00
        var creditGrade = 0.00
        
        // First compute the hourse earned
        for obj in currUserCourseTrack {
            // If user not enrolled in class
            if( obj["currSched"] as! Bool != true && obj["grade"] != nil) {
                if let i = Courses.indexOf(obj["courses"] as! PFObject) {
                    let tmp = Courses[i]["credits"] as! Double
                    creditsEarned = creditsEarned + tmp
                    let tmp2 = obj["grade"] as! Double
                    creditGrade = creditGrade + (tmp*tmp2)
                }
            }
        }
        
        // Compute GPA
        var gpa = creditGrade / creditsEarned
        if(creditsEarned == 0) { gpa = 0.00 }
        
        // Update locally
        currUserProfile[0]["hours"] = creditsEarned
        currUserProfile[0]["currGPA"] = gpa
        
        // Update on Database
        let query = PFQuery(className: "Profile")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if(error == nil) {
                for obj in objects! {
                    obj["currGpa"] = gpa
                    obj["hours"] = creditsEarned
                    obj.saveInBackground()
                }
            }
            else {
                print("User current GPA and hours was not updated")
            }
        }
    }
    
    @IBAction func addCourseToCurrent(sender: AnyObject) {
        if (course.text == "") {
            succMsg.text = "Please ensure a course is picked!"
        }
        else {
            succMsg.text = course.text! + " was successfully added to your current course list!"
            
            // Update information locally
            currUserCourseTrack[selectedCourseIndex]["currSched"] = true
            if let i = Courses.indexOf(currUserCourseTrack[selectedCourseIndex]["courses"] as! PFObject) {
                currUserSchedule.append(Courses[i])
            }
            self.computeUserGpa()
            
            //add code to add course and grade to database
            let query = PFQuery(className: "CourseTrack")
            query.whereKey("courses", equalTo: currUserCourseTrack[selectedCourseIndex]["courses"])
            query.whereKey("user", equalTo: PFUser.currentUser()!)
            query.limit = 1
            query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
                if(error == nil) {
                    for obj in objects! {
                        obj["currSched"] = true
                        obj.saveInBackground()
                    }
                }
                else {
                    print("Course was not added to the database")
                }
            }
        }
    }
}
