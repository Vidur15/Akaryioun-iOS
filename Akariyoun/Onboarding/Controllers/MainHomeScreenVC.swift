//
//  MainHomeScreenVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import CHIPageControl

class MainHomeScreenVC: UIViewController {

    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainPageControl: CHIPageControlJaloro!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let numberOfPages = 7
    
    var headingArr = ["Search Map","Property Search","Realestate","Members","Requests","Realestate Guide","Property Management"]
    var descArr = ["Find a site to offer for sale or rent","Find a site for sale or rent","Real estate Offers","Site Members","Search and request for a property that is not available","Find a nearby real estate office","The best way to manage your property"]
    var imageArr = ["2703060_maker_map_flag_location_icon","search","8150379_retail_price_tag_price tag_label_icon","79-users","pull-requests-1","290138_document_extension_file_format_paper_icon","office-1"]
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainCollectionView.delegate = self
                         self.mainCollectionView.dataSource = self
                         self.mainCollectionView.register(UINib(nibName: "OffersCVC", bundle: .main), forCellWithReuseIdentifier: "OffersCVC")
                  
        self.mainTableView.delegate = self
                             self.mainTableView.dataSource = self
                             let nib = UINib(nibName: "ActivitiesTVC", bundle: Bundle.main)
                             self.mainTableView.register(nib, forCellReuseIdentifier: "ActivitiesTVC")
               
        
        UIView.animate(withDuration: 1.0) {
            self.mainTableHeightConst.constant = CGFloat.greatestFiniteMagnitude
            self.mainTableView.reloadData()
            self.mainTableView.layoutIfNeeded()
            self.mainTableHeightConst.constant = self.mainTableView.contentSize.height
            self.mainScrollView.layoutIfNeeded()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signinBtnActon(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC" ) as? LoginVC  else { return }
    vc.modalPresentationStyle = .overFullScreen
    vc.modalTransitionStyle = .coverVertical
    vc.sender = self
    
    //  vc.meetUpModel = self.meetUpModel
    self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = self.mainCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < 6){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
       }
}
    
    
}


extension MainHomeScreenVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "ActivitiesTVC", for: indexPath) as? ActivitiesTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainImageView.image = UIImage.init(named: self.imageArr[indexPath.row])
        cell.headingLbl.text = self.headingArr[indexPath.row]
        cell.descLbl.text = self.descArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainHomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 7
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCVC", for: indexPath) as! OffersCVC
    //    cell.mainIMageView.image = UIImage.init(named: "animation")
            
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height))
     
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let total = scrollView.contentSize.width - scrollView.bounds.width
           let offset = scrollView.contentOffset.x
           let percent = Double(offset / total)
           
           let progress = percent * Double(self.numberOfPages - 1)
           
        self.mainPageControl.progress = progress
//           (self.pageControls + self.coloredPageControls).forEach { (control) in
//               control.progress = progress
//           }
       }
}
