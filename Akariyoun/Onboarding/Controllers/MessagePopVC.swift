//
//  MessagePopVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class MessagePopVC: UIViewController {

    @IBOutlet weak var mainTextView: UIView!
    @IBOutlet weak var roundCornerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.roundCornerView.roundCorners([.topLeft,.topRight], radius: 40)
        self.mainTextView.drawShadowwithCornerWithradius(radius: 22.5)
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
