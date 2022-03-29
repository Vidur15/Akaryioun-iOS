//
//  RealEstateContactVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class RealEstateContactVC: UIViewController {

    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var roundCornerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundCornerView.roundCorners([.topLeft,.topRight], radius: 40)
        // Do any additional setup after loading the view.
    }
}
