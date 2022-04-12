//
//  MainHomeScreenVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import CHIPageControl
import KYDrawerController

class MainHomeScreenVC: UIViewController {

    
    @IBOutlet weak var signinView: UIView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainPageControl: CHIPageControlJaloro!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var numberOfPages = 7
    
    var headingArr = ["Search Map".localized(),"Property Search".localized(),"Realestate".localized(),"Members".localized(),"Requests".localized(),"Directory".localized(),"Property Management".localized(),"News".localized(),"Finance".localized()]
    var descArr = ["Find a site to offer for sale or rent".localized(),"Find a site for sale or rent".localized(),"Real estate Offers".localized(),"Site Members".localized(),"Search and request for a property that is not available".localized(),"Find a nearby real estate office".localized(),"The best way to manage your property".localized(),"Find the latest Trending news around your area".localized(),"Find the best loans from both government and private players".localized()]
    var imageArr = ["2703060_maker_map_flag_location_icon","search","8150379_retail_price_tag_price tag_label_icon","79-users","pull-requests-1","290138_document_extension_file_format_paper_icon","office-1","290136_communication_internet_media_news_newspaper_icon","290136_communication_internet_media_news_newspaper_icon"]
    
    var timer : Timer?
    
    var bannerArr = [MainDataModel]()
    
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
        
        
        self.getBannerImages()
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
             super.awakeFromNib()
             
             tabBarItem.title = "Main".localized()
         }
      
    
    
    override func viewWillAppear(_ animated: Bool) {
        if kSharedUserDefaults.getLoggedInAccessToken() == ""{
            self.signinView.isHidden = false
            self.loginView.isHidden = true
        }else{
            self.signinView.isHidden = true
            self.loginView.isHidden = false
        }
    }
    
    
    func getBannerImages(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.bannerImage, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                       
                       //guard self != nil else { return }
                       CommonUtils.showHudWithNoInteraction(show: false)
                       if errorType == .requestSuccess {
                           let dicResponse = kSharedInstance.getDictionary(result)
                           let statusCodes = Int.getInt(statusCode)
                           switch statusCodes {
                           case 200:
                               if dicResponse["success"] as? Bool ?? false{
                                let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                                let propDict = kSharedInstance.getDictionaryArray(withDictionary: (dataDict["property"]))
                                
                            //    let abc3 = dictionary["data"] as? [[String:Any]] ?? []
                                self.bannerArr =  propDict.map({MainDataModel.init(dictionary: $0)})
                                self.numberOfPages = self.bannerArr.count
                                self.mainPageControl.numberOfPages = self.bannerArr.count
                                self.mainCollectionView.reloadData()
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
    
    
    @IBAction func logoutAction(_ sender: UIButton) {
        self.hitLogoutApi()
    }
    
    
    func hitLogoutApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.logout, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               
               //guard self != nil else { return }
               CommonUtils.showHudWithNoInteraction(show: false)
               if errorType == .requestSuccess {
                   let dicResponse = kSharedInstance.getDictionary(result)
                   let statusCodes = Int.getInt(statusCode)
                   switch statusCodes {
                   case 200:
                       if dicResponse["success"] as? Bool ?? false{
                           kSharedUserDefaults.setLoggedInAccessToken(loggedInAccessToken: "")
                           kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
                        kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: [:])
                        self.signinView.isHidden = false
                        self.loginView.isHidden = true
                        
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
    
    
    
    @IBAction func drawerAction(_ sender: UIButton) {
          DispatchQueue.main.async {
                     if let drawerController = self.navigationController?.parent as? KYDrawerController {
                         drawerController.drawerWidth = (kScreenWidth - 100)
                        
                         drawerController.drawerDirection = kSharedUserDefaults.getLanguageName() == "en" ? .left : .right
                         drawerController.setDrawerState(.opened, animated: true)
                     }
                 }
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
                if ((indexPath?.row)!  < (self.bannerArr.count - 1)){
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
        return 9
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
        return self.bannerArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCVC", for: indexPath) as! OffersCVC
      //  cell.mainIMageView.image = UIImage.init(named: "animation")
        if self.bannerArr[indexPath.item].images?.count > 0{
            cell.mainImageView.downlodeImage(serviceurl: self.bannerArr[indexPath.item].images?[0].name ?? "", placeHolder: UIImage.init(named: "Logo"))
        }
        cell.titleLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.bannerArr[indexPath.item].title ?? "" : self.bannerArr[indexPath.item].title_ar ?? ""
        cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.bannerArr[indexPath.item].description ?? "" : self.bannerArr[indexPath.item].description_ar ?? ""
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

       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchPropertyPopVC" ) as? SearchPropertyPopVC  else { return }
               vc.modalPresentationStyle = .overFullScreen
               vc.modalTransitionStyle = .coverVertical
               vc.senderVc = self
               
               //  vc.meetUpModel = self.meetUpModel
               self.present(vc, animated: true, completion: nil)
        }
       else if indexPath.row == 5{
           guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
            "RealEstateGuideVC" ) as? RealEstateGuideVC  else { return }
           self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3{
           guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
            "MembersVC" ) as? MembersVC  else { return }
           self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 6{
                  guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
                   "PropertyManagementVC" ) as? PropertyManagementVC  else { return }
                  self.navigationController?.pushViewController(vc, animated: true)
               }
        else if indexPath.row == 2{
                         guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
                          "RealEstateVC" ) as? RealEstateVC  else { return }
            vc.isFrom = true
                         self.navigationController?.pushViewController(vc, animated: true)
                      }
        else if indexPath.row == 4{
                     guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
                      "ViewController" ) as? ViewController  else { return }
        vc.isFrom = true
                     self.navigationController?.pushViewController(vc, animated: true)
                  }
        else if indexPath.row == 0{
                           guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
                            "SearchMapVC" ) as? SearchMapVC  else { return }
                           self.navigationController?.pushViewController(vc, animated: true)
                        }
        else if indexPath.row == 7{
           guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
            "NewsVC" ) as? NewsVC  else { return }
           self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 8{
           guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
            "FinanceVC" ) as? FinanceVC  else { return }
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
