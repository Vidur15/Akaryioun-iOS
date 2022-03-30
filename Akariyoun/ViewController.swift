//
//  ViewController.swift
//  Akariyoun
//
//  Created by vidur on 22/02/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class ViewController: UIViewController {
    
    @IBOutlet weak var backBtnOut: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var isFrom = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "RequestsTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "RequestsTVC")
        
        if self.isFrom{
                   if let drawerController = navigationController?.parent as? KYDrawerController {
                              drawerController.screenEdgePanGestureEnabled = false
                          }
                   self.backBtnOut.setImage(UIImage.init(named: "Back arrow"), for: .normal)
                   self.backBtnOut.backgroundColor = #colorLiteral(red: 0.134485513, green: 0.4705364108, blue: 0.7034772038, alpha: 1)
               }
        // Do any additional setup after loading the view.
    }
    
   @IBAction func addRequestAction(_ sender: UIButton) {
   guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseMemberVC" ) as? ChooseMemberVC  else { return }
   self.navigationController?.pushViewController(vc, animated: true)
   }
    
    @IBAction func drawerAction(_ sender: UIButton) {
        if self.isFrom{
            self.navigationController?.popViewController(animated: true)
        }else{
          DispatchQueue.main.async {
                     if let drawerController = self.navigationController?.parent as? KYDrawerController {
                         drawerController.drawerWidth = (kScreenWidth - 100)
                        
                         drawerController.drawerDirection = .left
                         drawerController.setDrawerState(.opened, animated: true)
                     }
                 }
        }
      }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RequestsTVC", for: indexPath) as? RequestsTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RequestDetailsVC" ) as? RequestDetailsVC  else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
