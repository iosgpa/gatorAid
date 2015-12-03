//
//  signUpViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/12/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UI variables
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var msg: UILabel!
    
    
    var pickMajor = ["Computer Engineering", "Computer Science", "Electrical Engineering"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var mPickerView = UIPickerView()
        
        mPickerView.delegate = self
        
        major.inputView = mPickerView
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickMajor.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickMajor[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        major.text = pickMajor[row]
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printMessage(message: String) {
        msg.text = message;
    }
    
    // This function performs the necessary test and print a message to the user
    func isInfoValid() -> Bool {
        if (username.text == "" || password.text == "" ||
            confirmPass.text == "" || email.text == "" ||
            confirmEmail.text == "" || major.text == "") {
                printMessage("One or more fields is missing")
                return false
        }
        if (password.text != confirmPass.text) {
            printMessage("Password confirmation does not match")
            return false
        }
        if (email.text != confirmEmail.text) {
            printMessage("Email confirmation does not match")
            return false
        }
        return true
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        if (isInfoValid()) {
            // Create user
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
            
            // Sign User in
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorStr = error.userInfo["error"] as? NSString
                    self.printMessage(errorStr as! String)
                }
                else {
                    self.getAllCourses()
                }
            }
        }
    }
    
    func createUserProfile(tmp:String, advisor:PFObject) {
        
        let user  = PFUser.currentUser() as! PFObject
        
        // Create profile for user
        let profile = PFObject(className: "Profile")
        profile.setObject(PFUser.currentUser()!, forKey: "user")
        profile.setObject(tmp, forKey: "majorId")
        profile.setObject(advisor, forKey: "advisor")
        currUserProfile.append(profile)
        do { try profile.save() }
        catch {
            self.printMessage("Could not complete profile")
        }
        
        // Update current User object
        user.setObject(advisor, forKey: "advisor")
        user.setObject(tmp, forKey: "majorId")
        user.setObject(profile, forKey: "profile")
        do { try user.save() }
        catch {
            self.printMessage("Could not complete profile")
        }
        
        
        // Find the corresponding advisor and major from parse collection
        let query:PFQuery = PFQuery(className: "Majors")
        query.whereKey("majorId", equalTo: tmp)
        query.orderByAscending("semester")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    // Create current user course track
                    let courseTrack = PFObject(className: "CourseTrack")
                    courseTrack.setObject(PFUser.currentUser()!, forKey: "user")
                    courseTrack.setObject(obj["course"], forKey: "courses")
                    do { try courseTrack.save() }
                    catch {
                        self.printMessage("Could not complete profile")
                    }
                    currUserMajor.append(obj)
                    currUserCourseTrack.append(courseTrack)
                }
                print("Course track and major retrieved. User profile set")
                self.goHome()
            }
            else {
                self.printMessage("Error: Could not retrieve majors catalog")
            }
        }
        
    }
    
    func getAllCourses() {
        
        // Pass in the selected user major
        var tmp:String
        if(self.major.text == "Computer Engineering"){ tmp = "CPE" }
        else if(self.major.text == "Computer Science") { tmp = "CS"}
        else { tmp = "EE" }
        
        let query = PFQuery(className: "Courses")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    Courses.append(obj)
                }
                print("All courses retrieved")
                self.setUserAdvisor(tmp)
            }
            else {
                self.printMessage("Error: Could load courses")
            }
        }
    }
    
    
    func setUserAdvisor(majorID:String) {
        // Get the advisor of the current user
        let query2 = PFQuery(className: "Advisors")
        query2.whereKey("majorId", equalTo: majorID)
        query2.limit = 1
        query2.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for o in objects! {
                    currUserAdvisor.append(o)
                    print("Advisor info retrieved and set locally")
                    self.createUserProfile(majorID, advisor: o)
                }
            }
            else {
                self.printMessage("Error: Could not add advisor to account")
            }
        }
    }
    
    func goHome() {
        print("TEST that all information is retrieved")
        print("*******************************************************")
        print(currUserProfile)
        print(currUserAdvisor)
        print(currUserMajor)
        print(currUserCourseTrack)
        print(Courses)
        print("*******************************************************\n")
        print("Going Home from Sign Up")
        performSegueWithIdentifier("signUp2Home", sender: nil)
    }
}
