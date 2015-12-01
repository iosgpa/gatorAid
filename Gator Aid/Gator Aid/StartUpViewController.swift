//
//  StartUpViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 11/14/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.releaseMemory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function cleans all the global variables
    func releaseMemory() {
        currUserProfile.removeAll()
        currUserSchedule.removeAll()
        currUserMajor.removeAll()
        currUserCourseTrack.removeAll()
        currUserAdvisor.removeAll()
        Courses.removeAll()
    }

}
