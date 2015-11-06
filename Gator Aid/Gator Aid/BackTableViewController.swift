//
//  BackTableViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 11/6/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class BackTableViewController: UITableViewController {
    
    // Variable Declaration
    var menuList = [String]()
    var menuListID = [String]()
    
    override func viewDidLoad() {
        // Set Menu options
        // Array must be same length
        menuList = ["Home", "Gpa", "Gpa tracker", "Course track"]
        menuListID = ["menu1", "menu2", "menu3", "menu4"]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(menuListID[indexPath.row], forIndexPath: indexPath) as! MenuOptionCustomCell
        cell.Label.text = menuList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
}