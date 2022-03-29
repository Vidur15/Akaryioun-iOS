//
//  RealEstateGuideVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class RealEstateGuideVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
               self.mainTableView.dataSource = self
               let nib = UINib(nibName: "RealEstateGuideTVC", bundle: Bundle.main)
               self.mainTableView.register(nib, forCellReuseIdentifier: "RealEstateGuideTVC")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RealEstateGuideVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RealEstateGuideTVC",
                for: indexPath) as? RealEstateGuideTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RealEstateContactVC" ) as? RealEstateContactVC  else { return }
          vc.modalPresentationStyle = .overFullScreen
          vc.modalTransitionStyle = .coverVertical
        //  vc.sender = self
          
          //  vc.meetUpModel = self.meetUpModel
        self.present(vc, animated: true, completion: nil)
    }
}
