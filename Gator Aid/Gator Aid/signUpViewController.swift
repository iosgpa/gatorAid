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
                    self.createUserProfile()
                }
            }
        }
    }
    
    func createUserProfile() {
        
        var profileSet = false
        var tmp:String
        var user  = PFUser.currentUser() as! PFObject
        
        if(major.text == "Computer Engineering"){ tmp = "CPE" }
        else if(major.text == "Computer Science") { tmp = "CS"}
        else { tmp = "EE" }
        
        // Create profile for user
        let profile = PFObject(className: "Profile")
        profile.setObject(PFUser.currentUser()!, forKey: "user")
        
        // Find the corresponding advisor and major from parse collection
        let query:PFQuery = PFQuery(className: "Majors")
        query.whereKey("majorId", equalTo: tmp)
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    // Update profile if not already done
                    if(!profileSet) {
                        profile.setObject(obj, forKey: "decMajor")
                        profile.setObject(obj["advisor"], forKey: "advisor")
                        currUserMajor.append(obj)
                        currUserProfile.append(profile)
                        do { try profile.save() }
                        catch {
                            self.printMessage("Could not complete profile")
                        }
                        
                        // Update user Object
                        user.setObject(obj["advisor"], forKey: "advisor")
                        user.setObject(obj, forKey: "decMajor")
                        user.setObject(profile, forKey: "profile")
                        do { try user.save() }
                        catch {
                            self.printMessage("Could not complete profile")
                        }
                        profileSet = true
                    }
                    
                    // Create current user course track
                    let courseTrack = PFObject(className: "CourseTrack")
                    courseTrack.setObject(PFUser.currentUser()!, forKey: "user")
                    courseTrack.setObject(obj["course"], forKey: "courses")
                    do { try courseTrack.save() }
                    catch {
                        self.printMessage("Could not complete profile")
                    }
                    currUserCourseTrack.append(courseTrack)
                }
                
                // Get the advisor of the current user
                var query2 = PFQuery(className: "Advisors")
                query2.whereKey("majorId", equalTo: tmp)
                query2.limit = 1
                query2.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        for o in objects! {
                            currUserAdvisor.append(o)
                            // GO home after user profile has been set up
                            self.goHome()
                        }
                    }
                    else {
                        self.printMessage("Error: Could not add advisor to account")
                    }
                }
            } // End if
            else {
                self.printMessage("Error: Could not retrieve majors catalog")
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
        print("*******************************************************\n")
        print("Going Home from Sign Up")
        performSegueWithIdentifier("signUp2Home", sender: nil)
    }
}
