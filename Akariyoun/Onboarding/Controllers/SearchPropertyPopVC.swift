//
//  SearchPropertyPopVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class SearchPropertyPopVC: UIViewController {
    
    @IBOutlet weak var roundCornerView: UIView!
    
    var senderVc : MainHomeScreenVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundCornerView.roundCorners([.topLeft,.topRight], radius: 40)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NeighbourhoodSelectionVC" ) as? NeighbourhoodSelectionVC  else { return }
        self.senderVc?.navigationController?.pushViewController(vc, animated: true)
    }
}
