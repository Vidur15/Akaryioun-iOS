//
//  NeighbourhoodSelectionVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class NeighbourhoodSelectionVC: UIViewController {

    @IBOutlet weak var backBtnOut: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.searchView.drawShadowwithCorner5()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "SelectionTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "SelectionTVC")
        
        self.backBtnOut.setImage(kSharedUserDefaults.getLanguageName() == "en" ? UIImage.init(named: "arrow-back") : UIImage.init(named: "Back arrow"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NeighbourhoodSelectionVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "SelectionTVC",
                for: indexPath) as? SelectionTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
