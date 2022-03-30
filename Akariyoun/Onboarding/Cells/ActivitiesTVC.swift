//
//  ActivitiesTVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class ActivitiesTVC: UITableViewCell {

    @IBOutlet weak var dropIcon: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
