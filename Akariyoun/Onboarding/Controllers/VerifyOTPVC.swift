//
//  VerifyOTPVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class VerifyOTPVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
