//
//  LoginVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var sender : MainHomeScreenVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func entryBtnAction(_ sender: UIButton) {
     self.dismiss(animated: true, completion: nil)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPVC" ) as? VerifyOTPVC  else { return }
          vc.modalPresentationStyle = .overFullScreen
          vc.modalTransitionStyle = .coverVertical
        //  vc.sender = self
          
          //  vc.meetUpModel = self.meetUpModel
        self.sender?.present(vc, animated: true, completion: nil)
    }
}
