//
//  PropertyDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class PropertyDetailsVC: UIViewController {

    @IBOutlet weak var authorImgView: UIImageView!
    @IBOutlet weak var authorNumberLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var topHeadingLbl: UILabel!
    
    @IBOutlet weak var lengthLimitView: UIView!
    @IBOutlet weak var earthView: UIView!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var userView: UIView!
    
    var idToSend = 0
    
    var propertyModel : MainDataModel?
    
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
                         
        self.getPropertyDetails()
        // Do any additional setup after loading the view.
    }
    
    
    func getPropertyDetails(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.propertyDetails + "?id=\(self.idToSend)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                
                //guard self != nil else { return }
                CommonUtils.showHudWithNoInteraction(show: false)
                if errorType == .requestSuccess {
                    let dicResponse = kSharedInstance.getDictionary(result)
                    let statusCodes = Int.getInt(statusCode)
                    switch statusCodes {
                    case 200:
                        if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let propModel = kSharedInstance.getDictionary(dataDict["property"])
                            self.propertyModel = MainDataModel.init(dictionary: propModel)
                            self.setData()
                            self.mainCollectionView.reloadData()
//                         print(self.propertyModel?.data?.property?.data?.count,"COUNT")
//                            self.mainTableView.reloadData()
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
    
    
    func setData(){
        self.topHeadingLbl.text = self.propertyModel?.title ?? ""
        self.authorNameLbl.text = "\(self.propertyModel?.member?.first_name ?? "") \(self.propertyModel?.member?.last_name ?? "")"
        self.authorNumberLbl.text = self.propertyModel?.member?.mobile_number ?? ""
        self.authorImgView.downlodeImage(serviceurl: self.propertyModel?.member?.profile_pic ?? "", placeHolder: UIImage.init(named: "Logo"))
    }
    
    
    @IBAction func messageBtnAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagePopVC" ) as? MessagePopVC  else { return }
       vc.modalPresentationStyle = .overFullScreen
       vc.modalTransitionStyle = .coverVertical
     //  vc.sender = self
       
       //  vc.meetUpModel = self.meetUpModel
       self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PropertyDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.propertyModel?.images?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyImagesCVC", for: indexPath) as! PropertyImagesCVC
        cell.mainImgView.downlodeImage(serviceurl: self.propertyModel?.images?[indexPath.item].name ?? "", placeHolder: UIImage.init(named: "Logo"))
    //    cell.mainIMageView.image = UIImage.init(named: "animation")
            
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height))
     
    }
}
