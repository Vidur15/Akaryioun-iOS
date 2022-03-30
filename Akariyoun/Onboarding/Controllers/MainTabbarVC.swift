//
//  MainTabbarVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
 self.setStatusBarColor()
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
      //  self.tabBar.selectedItem = UIColor.white.withAlphaComponent(0.5)
      //  self.tabBar.sizeThatFits(CGSize.init(width: view.frame.width, height: 240))
        
       print("CHECK VIUR")
       
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         print("CHECK VIUR")
    }
    
    
    override func viewWillLayoutSubviews() {
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("CHECK VIDUR HERE")
        if UIDevice().userInterfaceIdiom == .phone{
           // print("CHECK VIDUR HERE")
            var tabFrame = self.tabBar.frame
            tabFrame.size.height = 10
            tabFrame.origin.y = self.view.frame.size.height - 10
            self.tabBar.frame = tabFrame
        }
        
      //  myview?.configureUI()
    }

}
