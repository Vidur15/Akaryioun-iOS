//
//  MemberCallUsVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MemberCallUsVC: UIViewController {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var topicView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var yourNameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.messageView.drawShadowwithCornerWithradius(radius: 22.5)
         self.topicView.drawShadowwithCornerWithradius(radius: 22.5)
         self.emailView.drawShadowwithCornerWithradius(radius: 22.5)
         self.yourNameView.drawShadowwithCornerWithradius(radius: 22.5)
        // Do any additional setup after loading the view.
    }
}
