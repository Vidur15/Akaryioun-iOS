//
//  RealEstateVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class RealEstateVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "RealEstateTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "RealEstateTVC")
        // Do any additional setup after loading the view.
    }
}

extension RealEstateVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RealEstateTVC", for: indexPath) as? RealEstateTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
