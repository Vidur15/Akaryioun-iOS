//
//  PropertyDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class PropertyDetailsVC: UIViewController {

    @IBOutlet weak var lengthLimitView: UIView!
    @IBOutlet weak var earthView: UIView!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var userView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
       self.userView.drawShadowwithCorner()
        self.PriceView.drawShadowwithCorner()
        self.earthView.drawShadowwithCorner()
        self.lengthLimitView.drawShadowwithCorner()
        
        self.mainCollectionView.delegate = self
                                self.mainCollectionView.dataSource = self
                                self.mainCollectionView.register(UINib(nibName: "PropertyImagesCVC", bundle: .main), forCellWithReuseIdentifier: "PropertyImagesCVC")
                         
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PropertyDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 7
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyImagesCVC", for: indexPath) as! PropertyImagesCVC
    //    cell.mainIMageView.image = UIImage.init(named: "animation")
            
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height))
     
    }
}
