//
//  suggestedTrackViewController.swift
//  Gator Aid
//
//  Created by Charles,Kinderley on 12/2/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class suggestedTrackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // UI variables declarations
    @IBOutlet var Menu:UIBarButtonItem!
    @IBOutlet weak var majorName: UILabel!
    @IBOutlet weak var catalog: UILabel!
    @IBOutlet weak var majorCredits: UILabel!
    
    var blockColor = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMenuButton()
        self.printInfo()
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
    
    func printInfo() {
        if(currUserMajor.count != 0) {
            let tmp = String(currUserMajor[0]["majorName"]) + " Suggested Coursetrack"
            majorName.text = tmp
            catalog.text = String(currUserMajor[0]["catalogInfo"])
            majorCredits.text = "Total Credits: " + String(currUserMajor[0]["credits"])
        }
    }
    
    // Define each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("suggestedID", forIndexPath: indexPath) as! SuggestedTableViewCell
        
        // Find the course information
        if let i = Courses.indexOf(currUserMajor[indexPath.row]["course"] as! PFObject) {
            cell.courseId.text = String(Courses[i]["courseId"])
            cell.courseDsc.text = String(Courses[i]["courseName"])
            cell.credits.text = "Credits: " + String(Courses[i]["credits"])
            cell.semester.text = "Semester: " + String(currUserMajor[indexPath.row]["semester"])
        }
        
        cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        return cell
    }
    
    // return the number of rows in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currUserMajor.count
    }
    
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
}
