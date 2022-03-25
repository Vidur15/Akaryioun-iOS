//
//  AddRequestVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class AddRequestVC: UIViewController {

    @IBOutlet weak var sendRequestView: UIView!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var yourNameView: UIView!
    @IBOutlet weak var firstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.firstView.drawShadowwithCornerWithradius(radius: 22.5)
        self.yourNameView.drawShadowwithCornerWithradius(radius: 22.5)
        self.mobileNumberView.drawShadowwithCornerWithradius(radius: 22.5)
        self.sendRequestView.drawShadowwithCornerWithradius(radius: 22.5)
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
