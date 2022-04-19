//
//  PropertyDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class PropertyDetailsVC: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var earthViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    
    
    @IBOutlet weak var secondMobileLbl: UILabel!
    @IBOutlet weak var westLengthLbl: UILabel!
    @IBOutlet weak var eastLengthLbl: UILabel!
    @IBOutlet weak var southLengthLbl: UILabel!
    @IBOutlet weak var northLengthLb: UILabel!
    @IBOutlet weak var westBorderLbl: UILabel!
    @IBOutlet weak var eastBorderLbl: UILabel!
    
    @IBOutlet weak var southBorderLbl: UILabel!
    @IBOutlet weak var northBorderLbl: UILabel!
    @IBOutlet weak var numPlannedLbl: UILabel!
    @IBOutlet weak var blockNumberLbl: UILabel!
    @IBOutlet weak var postNumberLbl: UILabel!
    
    
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
    
    var propertyModel : PropertyDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        self.setStatusBarColor()
       self.userView.drawShadowwithCorner()
        self.PriceView.drawShadowwithCorner()
        self.earthView.drawShadowwithCorner()
        self.lengthLimitView.drawShadowwithCorner()
        
        self.mainCollectionView.delegate = self
                                self.mainCollectionView.dataSource = self
                                self.mainCollectionView.register(UINib(nibName: "PropertyImagesCVC", bundle: .main), forCellWithReuseIdentifier: "PropertyImagesCVC")
        
        self.mainTableView.delegate = self
               self.mainTableView.dataSource = self
               let nib = UINib(nibName: "EarthInfoTVC", bundle: Bundle.main)
               self.mainTableView.register(nib, forCellReuseIdentifier: "EarthInfoTVC")
                         
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
//                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
//                            let propModel = kSharedInstance.getDictionary(dataDict["property"])
                            self.propertyModel = PropertyDetailsModel.init(dictionary: dicResponse as NSDictionary)
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
        self.topHeadingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.propertyModel?.data?.property?.title ?? "" : self.propertyModel?.data?.property?.title_ar ?? ""
        self.authorNameLbl.text = "\(self.propertyModel?.data?.property?.member?.first_name ?? "") \(self.propertyModel?.data?.property?.member?.last_name ?? "")"
        self.authorNumberLbl.text = self.propertyModel?.data?.property?.member?.mobile_number ?? ""
        self.authorImgView.downlodeImage(serviceurl: self.propertyModel?.data?.property?.member?.profile_pic ?? "", placeHolder: UIImage.init(named: "Logo"))
        self.secondMobileLbl.text = "Call".localized() + " : \(self.propertyModel?.data?.property?.member?.mobile_number ?? "")"
        
        self.northBorderLbl.text = self.propertyModel?.data?.property?.land_north ?? ""
        self.southBorderLbl.text = self.propertyModel?.data?.property?.land_south ?? ""
        self.eastBorderLbl.text = self.propertyModel?.data?.property?.land_east ?? ""
        self.westBorderLbl.text = self.propertyModel?.data?.property?.land_west ?? ""
        
        self.northLengthLb.text = self.propertyModel?.data?.property?.land_m_north ?? ""
        self.southLengthLbl.text = self.propertyModel?.data?.property?.land_m_south ?? ""
        self.eastLengthLbl.text = self.propertyModel?.data?.property?.land_m_east ?? ""
        self.westLengthLbl.text = self.propertyModel?.data?.property?.land_m_west ?? ""
        
        
        if self.propertyModel?.data?.property?.property_land_info?.count == 0{
            self.earthViewHeightConst.constant = 0
            self.earthView.isHidden = true
        }else{
            self.earthView.isHidden = false
        UIView.animate(withDuration: 1.0) {
        
                   self.mainTableHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
            self.mainTableView.reloadSections([0], with: .automatic)
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableHeightConst.constant = self.mainTableView.contentSize.height
            self.earthViewHeightConst.constant = (self.mainTableHeightConst.constant + 48)
                   self.mainScrollView.layoutIfNeeded()
               }
        }
        
    //    self.postNumberLbl.text = self.propertyModel?.property
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
        
        return self.propertyModel?.data?.property?.images?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyImagesCVC", for: indexPath) as! PropertyImagesCVC
        cell.mainImgView.downlodeImage(serviceurl: self.propertyModel?.data?.property?.images?[indexPath.item].name ?? "", placeHolder: UIImage.init(named: "Logo"))
        
    //    cell.mainIMageView.image = UIImage.init(named: "animation")
            
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height))
     
    }
}
extension PropertyDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyModel?.data?.property?.property_land_info?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "EarthInfoTVC", for: indexPath) as? EarthInfoTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.plannedNumberLbl.text = self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.sector_num ?? ""
        cell.blockNumberLbl.text = "\(self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.blockNum ?? 0)"
        cell.partNumberLbl.text = self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.land_num ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
