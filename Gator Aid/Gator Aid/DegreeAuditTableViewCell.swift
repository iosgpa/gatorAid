//
//  DegreeAuditTableViewCell.swift
//  Gator Aid
//
//  Created by Charles,Kinderley on 11/29/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class DegreeAuditTableViewCell: UITableViewCell {

    @IBOutlet weak var courseId: UILabel!
    @IBOutlet weak var courseDescription: UILabel!
    @IBOutlet weak var courseGrade: UILabel!
    @IBOutlet weak var courseCredit: UILabel!
    @IBOutlet weak var courseStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
