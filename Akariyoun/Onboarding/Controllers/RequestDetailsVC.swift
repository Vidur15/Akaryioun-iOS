//
//  RequestDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class RequestDetailsVC: UIViewController {

    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var requestDescLbl: UILabel!
    @IBOutlet weak var requestTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.cardView.drawShadowwithCorner()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
