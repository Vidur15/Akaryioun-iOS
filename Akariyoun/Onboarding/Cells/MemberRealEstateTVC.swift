//
//  MemberRealEstateTVC.swift
//  Akariyoun
//
//  Created by vidur on 01/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MemberRealEstateTVC: UITableViewCell {

    @IBOutlet weak var priceBtnTopConst: NSLayoutConstraint!
    @IBOutlet weak var priceBtnHeightConst: NSLayoutConstraint!
    @IBOutlet weak var priceBtnOut: UIButton!
    @IBOutlet weak var landLbl: UILabel!
    @IBOutlet weak var blockLbl: UILabel!
    @IBOutlet weak var sectoreLbl: UILabel!
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
