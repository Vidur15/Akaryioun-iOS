//
//  ProfileVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainTableViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var animateView: UIView!
    
    var selection = 1
    
    var requestSelect = 0
    var offerselect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "MemberRealEstateTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "MemberRealEstateTVC")
        
        let nib2 = UINib(nibName: "CommonCollapseTVC", bundle: Bundle.main)
        self.mainTableView.register(nib2, forCellReuseIdentifier: "CommonCollapseTVC")
        let nib1 = UINib(nibName: "CommonExpandTVC", bundle: Bundle.main)
        self.mainTableView.register(nib1, forCellReuseIdentifier: "CommonExpandTVC")
        
        UIView.animate(withDuration: 1.0) {
                   self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                   self.mainScrollView.layoutIfNeeded()
               }

        // Do any additional setup after loading the view.
    }
    
    func transformView(sender:UIView) {
        UIView.animate(withDuration: 0.5) {
            print(sender.frame.origin.x,"X POSITION")
            self.animateView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
        }
    }
    
    @IBAction func selectionAction(_ sender: UIButton) {
        self.transformView(sender: sender)
        self.selection = sender.tag
        print(self.selection,"CHECK")
     
        UIView.animate(withDuration: 1.0) {
                   self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                   self.mainScrollView.layoutIfNeeded()
               }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension ProfileVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selection == 1{
            return 10
        }else if self.selection == 2{
            return 10
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selection == 1{
            guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "MemberRealEstateTVC",
                                                                    for: indexPath) as? MemberRealEstateTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }else if self.selection == 2{
            if indexPath.row == self.requestSelect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        }else{
            if indexPath.row == self.offerselect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selection == 2{
            self.requestSelect = indexPath.row
        }else if self.selection == 3{
            self.offerselect = indexPath.row
        }
        self.mainTableView.reloadData()
    }
}
