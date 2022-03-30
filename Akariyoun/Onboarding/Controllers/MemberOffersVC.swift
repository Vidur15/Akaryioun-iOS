//
//  MemberOffersVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MemberOffersVC: UIViewController {

    @IBOutlet weak var mainTabkeView: UITableView!
    
    var select = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTabkeView.delegate = self
                                 self.mainTabkeView.dataSource = self
                                 let nib = UINib(nibName: "CommonCollapseTVC", bundle: Bundle.main)
                                 self.mainTabkeView.register(nib, forCellReuseIdentifier: "CommonCollapseTVC")
                          let nib1 = UINib(nibName: "CommonExpandTVC", bundle: Bundle.main)
                          self.mainTabkeView.register(nib1, forCellReuseIdentifier: "CommonExpandTVC")
            
            self.mainTabkeView.reloadData()
        self.mainTabkeView.reloadSections([0], with: .automatic)
        // Do any additional setup after loading the view.
    }
}

extension MemberOffersVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.select{
            guard let cell = self.mainTabkeView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
        }else{
        guard let cell = self.mainTabkeView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
            
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select = indexPath.row
        self.mainTabkeView.reloadData()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
