//
//  SuggestedTableViewCell.swift
//  Gator Aid
//
//  Created by Charles,Kinderley on 12/2/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class SuggestedTableViewCell: UITableViewCell {

    @IBOutlet weak var courseId: UILabel!
    @IBOutlet weak var courseDsc: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var semester: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
