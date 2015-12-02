//
//  CourseAvbleTableViewCell.swift
//  Gator Aid
//
//  Created by Charles,Kinderley on 12/2/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class CourseAvbleTableViewCell: UITableViewCell {

    // UI variable declarations
    @IBOutlet weak var courseId: UILabel!
    @IBOutlet weak var offered: UILabel!
    @IBOutlet weak var courseDesc: UILabel!
    @IBOutlet weak var credits: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
