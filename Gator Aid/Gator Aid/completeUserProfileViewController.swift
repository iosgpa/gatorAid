//
//  completeUserProfileViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 12/1/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class completeUserProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var Menu: UIBarButtonItem!
    @IBOutlet weak var succMsg: UILabel!
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var grade: UITextField!
    var pickCourse = currUserCourseTrack
    var pickGrade = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "E"]
    var pickGradeNum = [4.00, 3.67, 3.33, 3.00, 2.67, 2.33, 2.00, 1.67, 1.33, 1.00, 0.67, 0]
    var selectedCourseIndex: Int = 0
    var selectedGradeNum: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        
        var cPickerView = UIPickerView()
        var gPickerView = UIPickerView()
        
        cPickerView.delegate = self
        gPickerView.delegate = self
        
        course.inputView = cPickerView
        grade.inputView = gPickerView
        
        cPickerView.tag = 0
        gPickerView.tag = 1
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
        if pickerView.tag == 0 {
            return pickCourse.count
        }
        else if pickerView.tag == 1 {
            return pickGrade.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return pickCourse[row]["courses"]["courseName"] as? String
        }
        else if pickerView.tag == 1 {
            return pickGrade[row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            course.text = pickCourse[row]["courses"]["courseName"] as? String
            selectedCourseIndex = row
        }
        else if pickerView.tag == 1 {
            grade.text = pickGrade[row]
            selectedGradeNum = pickGradeNum[row]
        }
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func addCourseToHist(sender: AnyObject) {
        if (course.text == "" || grade.text == "") {
            succMsg.text = "Please ensure both a course and grade are picked!"
        }
        else {
            succMsg.text = course.text! + " was successfully added to your previous courses with the grade: " + grade.text!
            
            // Update information locally
            currUserCourseTrack[selectedCourseIndex]["grade"] = selectedGradeNum
            currUserCourseTrack[selectedCourseIndex]["currSched"] = false
            if let i = currUserSchedule.indexOf(currUserCourseTrack[selectedCourseIndex]["courses"] as! PFObject) {
                currUserSchedule.removeAtIndex(i)
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
                        obj["grade"] = self.selectedGradeNum
                        obj["currSched"] = false
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
