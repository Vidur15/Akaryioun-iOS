//
//  PropertyManagementVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class PropertyManagementVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
