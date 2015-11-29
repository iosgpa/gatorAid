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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daCourse", forIndexPath: indexPath) as! DegreeAuditTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
