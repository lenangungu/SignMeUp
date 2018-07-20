//
//  StudyTableViewCell.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/10/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit

class StudyTableViewCell: UITableViewCell {
    @IBOutlet var createdByLabel: UILabel!
    @IBOutlet var ministryLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var numOfPeopleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
