//
//  completeUserProfileViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 12/1/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class completeUserProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var succMsg: UILabel!
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var grade: UITextField!
    var pickCourse = [] //needs a method to populate from Parse
    var pickGrade = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "E"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var cPickerView = UIPickerView()
        var gPickerView = UIPickerView()
        
        cPickerView.delegate = self
        gPickerView.delegate = self
        
        course.inputView = cPickerView
        grade.inputView = gPickerView
        
        cPickerView.tag = 0
        gPickerView.tag = 1
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
            return pickCourse[row] as! String
        }
        else if pickerView.tag == 1 {
            return pickGrade[row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            course.text = pickCourse[row] as! String
        }
        else if pickerView.tag == 1 {
            grade.text = pickGrade[row]
            self.view.endEditing(true)
        }
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCourseToHist(sender: AnyObject) {
        if (course.text == "" || grade.text == "") {
            succMsg.text = "Please ensure both a course and grade are picked!"
        }
        else {
            succMsg.text = course.text! + "was successfully added to your previous courses with the grade: " + grade.text!
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
