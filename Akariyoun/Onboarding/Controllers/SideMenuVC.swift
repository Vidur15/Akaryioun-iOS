//
//  SideMenuVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class SideMenuVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var menuArr = ["Real Estate","Members","Request","Who are we","Call Us","Language"]
    var imageArr = ["1530085_building_business_city_commercial_company_icon (1)","79-users-1","pull-requests-1","8324228_ui_essential_app_question_help_icon","Phone","2135789_earth_language_planet_icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        self.mainTableView.delegate = self
                      self.mainTableView.dataSource = self
                      let nib = UINib(nibName: "SideMenuTVC", bundle: Bundle.main)
                      self.mainTableView.register(nib, forCellReuseIdentifier: "SideMenuTVC")
        // Do any additional setup after loading the view.
    }
}

extension SideMenuVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as? SideMenuTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainLbl.text = self.menuArr[indexPath.row]
        cell.mainImageView.image = UIImage.init(named: self.imageArr[indexPath.row])
        if indexPath.row == 5{
            cell.hideImageView.isHidden = true
        }else{
            cell.hideImageView.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}