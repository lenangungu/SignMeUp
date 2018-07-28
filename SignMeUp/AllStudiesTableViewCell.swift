//
//  AllStudiesTableViewCell.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/23/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit

class AllStudiesTableViewCell: UITableViewCell {
    
    @IBOutlet var createdByLabel: UILabel!
    @IBOutlet var ministryLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var numOfpeopleLabel: UILabel!
    //    @IBOutlet var createdByLabel: UILabel!
//    @IBOutlet var ministryLabel: UILabel!
//    @IBOutlet var dateLabel: UILabel!
//    @IBOutlet var timeLabel: UILabel!
//    @IBOutlet var numOfPeopleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
