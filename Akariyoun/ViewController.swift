//
//  ViewController.swift
//  Akariyoun
//
//  Created by vidur on 22/02/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "RequestsTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "RequestsTVC")
        // Do any additional setup after loading the view.
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
}
