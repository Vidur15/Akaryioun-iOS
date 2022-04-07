//
//  FinanceVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class FinanceVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func privateLoansAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
               "LoanListVC" ) as? LoanListVC  else { return }
        vc.isFrom = "private"
              self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func governmentLoanAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
               "LoanListVC" ) as? LoanListVC  else { return }
        vc.isFrom = "govt"
              self.navigationController?.pushViewController(vc, animated: true)
    }
}
