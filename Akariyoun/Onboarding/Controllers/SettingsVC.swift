//
//  SettingsVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAccountAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
     "DeleteAccountVC" ) as? DeleteAccountVC  else { return }
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingsBtnAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
               "AccountSettingsVC" ) as? AccountSettingsVC  else { return }
              self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
