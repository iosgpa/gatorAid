//
//  currentScheduleViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 12/3/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

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
    
    @IBAction func addCourseToCurrent(sender: AnyObject) {
        if (course.text == "") {
            succMsg.text = "Please ensure a course is picked!"
        }
        else {
            succMsg.text = course.text! + " was successfully added to your current course list!"
            currUserCourseTrack[selectedCourseIndex]["currSched"] = true
            //add code to add course and grade to database
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
