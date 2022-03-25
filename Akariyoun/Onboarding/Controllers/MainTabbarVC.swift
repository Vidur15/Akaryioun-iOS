//
//  MainTabbarVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
 self.setStatusBarColor()
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
      //  self.tabBar.sizeThatFits(CGSize.init(width: view.frame.width, height: 240))
        
        // Do any additional setup after loading the view.
    }
}
