//
//  NewsDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class NewsDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainColelctionView: UICollectionView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    var idToSend = -1
    
    @IBOutlet weak var backBtnOut: UIButton!
    var newsDetailModel : NewsDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.mainColelctionView.delegate = self
            self.mainColelctionView.dataSource = self
        self.mainColelctionView.register(UINib(nibName: "MoreNewsCVC", bundle: .main), forCellWithReuseIdentifier: "MoreNewsCVC")
        
        self.getNewsDetailsApi()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        self.backBtnOut.setImage(kSharedUserDefaults.getLanguageName() == "en" ? UIImage.init(named: "arrow-back") : UIImage.init(named: "Back arrow"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func getNewsDetailsApi(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.newsDetail + "?id=\(self.idToSend)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            //guard self != nil else { return }
            CommonUtils.showHudWithNoInteraction(show: false)
            if errorType == .requestSuccess {
                let dicResponse = kSharedInstance.getDictionary(result)
                let statusCodes = Int.getInt(statusCode)
                switch statusCodes {
                case 200:
                    if dicResponse["success"] as? Bool ?? false{
                        self.newsDetailModel = NewsDetailModel.init(dictionary: dicResponse as NSDictionary)
                        
                        self.mainImageView.downlodeImage(serviceurl: self.newsDetailModel?.data?.news?.image ?? "", placeHolder: UIImage.init(named: "Logo"))
                        self.titleLbl.text = self.newsDetailModel?.data?.news?.title ?? ""
                        self.descLbl.text = self.newsDetailModel?.data?.news?.description ?? ""
                        
                        self.mainColelctionView.reloadData()
                    }else{
                        showAlertMessage.alert(message: String.getString(dicResponse["message"]))
                    }
                default:
                    
                    showAlertMessage.alert(message: String.getString(dicResponse["message"]))
                }
            } else if errorType == .noNetwork {
                showAlertMessage.alert(message: kNoInternetMsg)
                
            } else {
                showAlertMessage.alert(message: kDefaultErrorMsg)
            }
        }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return self.newsDetailModel?.data?.related_news?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreNewsCVC", for: indexPath) as! MoreNewsCVC
     //    cell.mainIMageView.image = UIImage.init(named: "animation")
        cell.mainImageView.downlodeImage(serviceurl: self.newsDetailModel?.data?.related_news?[indexPath.item].image ?? "", placeHolder: UIImage.init(named: "Logo"))
        cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.newsDetailModel?.data?.related_news?[indexPath.item].title ?? "" : self.newsDetailModel?.data?.related_news?[indexPath.item].title_ar ?? ""
        cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.newsDetailModel?.data?.related_news?[indexPath.item].description ?? "" : self.newsDetailModel?.data?.related_news?[indexPath.item].description_ar ?? ""
         return cell
     }
     
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: (collectionView.frame.width - 60), height: (collectionView.frame.height))
      
     }

    
}

