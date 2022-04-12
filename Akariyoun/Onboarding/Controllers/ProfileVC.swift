//
//  ProfileVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class ProfileVC: UIViewController {
    
    @IBOutlet var btnSelectOutColl: [UIButton]!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNumLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainTextVew: UITextView!
    
    
    @IBOutlet  var mainTableBottomCont: NSLayoutConstraint!
    @IBOutlet  var whoWeAreBottomConst: NSLayoutConstraint!
    @IBOutlet weak var whoWeAreView: UIView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainTableViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var animateView: UIView!
    
    var selection = 1
    
    var requestSelect = 0
    var offerselect = 0
    
    var coverUrl = ""
    var profileUrl = ""
    
    var profileDetailModel : MemberDetailsModel?
    
    var dateF = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "MemberRealEstateTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "MemberRealEstateTVC")
        
        let nib2 = UINib(nibName: "CommonCollapseTVC", bundle: Bundle.main)
        self.mainTableView.register(nib2, forCellReuseIdentifier: "CommonCollapseTVC")
        let nib1 = UINib(nibName: "CommonExpandTVC", bundle: Bundle.main)
        self.mainTableView.register(nib1, forCellReuseIdentifier: "CommonExpandTVC")
        
        let nib3 = UINib(nibName: "AddRequestOfferTVC", bundle: Bundle.main)
        self.mainTableView.register(nib3, forCellReuseIdentifier: "AddRequestOfferTVC")
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        
        
        UIView.animate(withDuration: 1.0) {
            self.mainTableBottomCont.isActive = false
            self.whoWeAreBottomConst.isActive = true
            self.mainTableView.isHidden = true
            self.whoWeAreView.isHidden = false
            
         
            
            
                   self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
            self.mainTableView.reloadSections([0], with: .automatic)
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                   self.mainScrollView.layoutIfNeeded()
               }
        
        self.mainTextVew.addPadding(to: self.mainTextVew)
         self.mainTextVew.textAlignment = kSharedUserDefaults.getLanguageName() == "en" ? .left : .right
        
        self.dateF.dateFormat = "dd MMM, yyyy hh:mm a"
        
        self.getUserDetails()
        // Do any additional setup after loading the view.
    }
    
    
    func getUserDetails(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.profileDetails, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                   
                   //guard self != nil else { return }
                   CommonUtils.showHudWithNoInteraction(show: false)
                   if errorType == .requestSuccess {
                       let dicResponse = kSharedInstance.getDictionary(result)
                       let statusCodes = Int.getInt(statusCode)
                       switch statusCodes {
                       case 200:
                           if dicResponse["success"] as? Bool ?? false{
                          //  let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                         //   let userDict = kSharedInstance.getDictionary(dataDict["profileDetail"])
                        //    self.userNameTextF.text = userDict["mobile_number"] as? String ?? ""
                            self.profileDetailModel = MemberDetailsModel.init(dictionary: dicResponse as NSDictionary)
                            self.setData()
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
        self.coverImageView.downlodeImage(serviceurl: self.profileDetailModel?.data?.profileDetail?.cover_photo ?? "", placeHolder: UIImage.init(named: "upload"))
        self.coverUrl = self.profileDetailModel?.data?.profileDetail?.cover_photo ?? ""
        self.profileUrl = self.profileDetailModel?.data?.profileDetail?.profile_pic ?? ""
        self.profileImgView.downlodeImage(serviceurl: self.profileDetailModel?.data?.profileDetail?.profile_pic ?? "", placeHolder: UIImage.init(named: ""))
        self.nameLbl.text = "\(self.profileDetailModel?.data?.profileDetail?.first_name ?? "") \(self.profileDetailModel?.data?.profileDetail?.last_name ?? "")"
        self.mobileNumLbl.text = "Phone - ".localized() + "\(self.profileDetailModel?.data?.profileDetail?.mobile_number ?? "")"
        self.emailLbl.text = "Email - ".localized() + "\(self.profileDetailModel?.data?.profileDetail?.email ?? "")"
        self.mainTextVew.text = self.profileDetailModel?.data?.profileDetail?.info?.who_we_are ?? ""
    }

    
    
    @IBAction func chooseCoverImgAction(_ sender: UIButton) {
           ImagePickerHelper.shared.showPickerController(reference: self) { (image,str) -> (Void) in
                          self.coverImageView.contentMode = .scaleAspectFill
                          self.coverImageView.image = image
            self.uploadData(imageToSend: image ?? UIImage.init(named: "upload")!, name: str, tag: sender.tag, type: "cover")
            }
       }
    
       @IBAction func chooseProfileImgAction(_ sender: UIButton) {
        ImagePickerHelper.shared.showPickerController(reference: self) { (image,str) -> (Void) in
                                 self.profileImgView.contentMode = .scaleAspectFill
                                 self.profileImgView.image = image
            self.uploadData(imageToSend: image ?? UIImage.init(named: "upload")!, name: str, tag: sender.tag, type: "profile")
                    }
       }
    
  
    func uploadData(imageToSend : UIImage,name : String,tag : Int,type : String) {
        CommonUtils.showHudWithNoInteraction(show: true)
              AWSS3Manager.shared.uploadImage(image: imageToSend, progress: nil) { (result, error) in
                  CommonUtils.showHudWithNoInteraction(show: false)
                if type == "cover"{
                     self.coverUrl = result as? String ?? ""
                    self.updateCoverImage()
                }else{
                  self.profileUrl = result as? String ?? ""
                    self.updateProfileImage()
                }
                  //   self.checkImageView.isHidden = false
                  //     self.customArr[tag].imageUrl = result as? String ?? ""
                  print(result,"RESULT")
              }
          }
    
    func updateCoverImage(){
        let params : [String : Any] = ["cover_photo" : self.coverUrl]
                    
                    TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.updateCoverPhoto, requestMethod: .PUT, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                        
                        //guard self != nil else { return }
                        CommonUtils.showHudWithNoInteraction(show: false)
                        if errorType == .requestSuccess {
                            let dicResponse = kSharedInstance.getDictionary(result)
                            let statusCodes = Int.getInt(statusCode)
                            switch statusCodes {
                            case 200:
                                if dicResponse["success"] as? Bool ?? false{
                                //  showAlertMessage.alert1(message: "Account Details Updated", sender: self)
                               //     self.navigationController?.popViewController(animated: true)
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
    
    
    
    func updateProfileImage(){
        let params : [String : Any] = ["profile_picture" : self.profileUrl]
                    
                    TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.updateProfilePic, requestMethod: .PUT, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                        
                        //guard self != nil else { return }
                        CommonUtils.showHudWithNoInteraction(show: false)
                        if errorType == .requestSuccess {
                            let dicResponse = kSharedInstance.getDictionary(result)
                            let statusCodes = Int.getInt(statusCode)
                            switch statusCodes {
                            case 200:
                                if dicResponse["success"] as? Bool ?? false{
                            //      showAlertMessage.alert1(message: "Account Details Updated", sender: self)
                               //     self.navigationController?.popViewController(animated: true)
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
    
    
    func transformView(sender:UIView) {
        UIView.animate(withDuration: 0.5) {
            print(sender.frame.origin.x,"X POSITION")
           // self.animateView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
            self.animateView.transform = kSharedUserDefaults.getLanguageName() == "en" ?  CGAffineTransform(translationX: sender.frame.origin.x, y: 0) : CGAffineTransform(translationX: -(sender.frame.origin.x), y: 0)
        }
    }
    
    @IBAction func selectionAction(_ sender: UIButton) {
        if kSharedUserDefaults.getLanguageName() == "en"{
            self.transformView(sender: sender)
        }else{
            print(sender.tag)
            let abc = (self.btnSelectOutColl.count - 1)
            print(abc - sender.tag,"checggg")
            self.transformView(sender: self.btnSelectOutColl[abc - sender.tag])
        }
        
        self.selection = sender.tag
       
     
        if selection == 0{
            UIView.animate(withDuration: 1.0) {
                self.mainTableBottomCont.isActive = false
                self.whoWeAreBottomConst.isActive = true
                self.mainTableView.isHidden = true
                self.whoWeAreView.isHidden = false
                       self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                       self.mainTableView.reloadData()
                       self.mainTableView.layoutIfNeeded()
                       self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                       self.mainScrollView.layoutIfNeeded()
                   }

        }else{
        
        UIView.animate(withDuration: 1.0) {
            self.mainTableBottomCont.isActive = true
            self.whoWeAreBottomConst.isActive = false
            self.mainTableView.isHidden = false
            self.whoWeAreView.isHidden = true
                   self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
            self.mainTableView.reloadSections([0], with: .automatic)
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                   self.mainScrollView.layoutIfNeeded()
               }
        }
    }
    
    
    @IBAction func saveWhoWeAreAction(_ sender: UIButton) {
        if self.mainTextVew.text.count == 0{
            CommonUtils.showToast(message: "Please enter details about yourself".localized())
            return
        }else{
            self.hitUpdateWhoWeAreApi()
        }
    }
    
    
    func hitUpdateWhoWeAreApi(){
        
        let params : [String : Any] = ["who_we_are" : self.mainTextVew.text ?? ""]
                    
                    TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.updateInfo, requestMethod: .PUT, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                        
                        //guard self != nil else { return }
                        CommonUtils.showHudWithNoInteraction(show: false)
                        if errorType == .requestSuccess {
                            let dicResponse = kSharedInstance.getDictionary(result)
                            let statusCodes = Int.getInt(statusCode)
                            switch statusCodes {
                            case 200:
                                if dicResponse["success"] as? Bool ?? false{
                                  showAlertMessage.alert(message: "Profile Details Updated".localized())
                               //     self.navigationController?.popViewController(animated: true)
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
}



extension ProfileVC: UITableViewDelegate,UITableViewDataSource {
    
//    @objc func addOfferAction(sender : UIButton){
       
//    }
    
    @objc func addRequestAction(sender : UIButton){
        if sender.tag == 0{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRequestVC" ) as? AddRequestVC  else { return }
            vc.isFrom = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRequestVC" ) as? AddRequestVC  else { return }
                   vc.isFrom = 2
                   self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selection == 1{
            return self.profileDetailModel?.data?.profileDetail?.real_state?.count ?? 0
        }else if self.selection == 2{
            return ((self.profileDetailModel?.data?.profileDetail?.requests?.count ?? 0) + 1)
        }else{
            return ((self.profileDetailModel?.data?.profileDetail?.offers?.count ?? 0) + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selection == 1{
            guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "MemberRealEstateTVC",
                                                                    for: indexPath) as? MemberRealEstateTVC else { return UITableViewCell() }
            cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.real_state?[indexPath.row].title ?? "" : self.profileDetailModel?.data?.profileDetail?.real_state?[indexPath.row].title_ar ?? ""
            //        cell.descLbl.text = self.propertyModel?.data?.property?.data?[indexPath.row].description ?? ""
                   if self.self.profileDetailModel?.data?.profileDetail?.real_state?[indexPath.row].images?.count > 0{
                        cell.mainImageView.downlodeImage(serviceurl: self.profileDetailModel?.data?.profileDetail?.real_state?[indexPath.row].images?[0].name ?? "", placeHolder: UIImage.init(named: "Logo"))
                    }
                    
                    cell.priceBtnOut.setTitle("Asking for ".localized() + "\( self.profileDetailModel?.data?.profileDetail?.real_state?[indexPath.row].price ?? 0) SAR", for: .normal)
            cell.selectionStyle = .none
            return cell
        }else if self.selection == 2{
            if indexPath.row == self.profileDetailModel?.data?.profileDetail?.requests?.count{
                 guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "AddRequestOfferTVC", for: indexPath) as? AddRequestOfferTVC else { return UITableViewCell() }
                cell.addBtnOut.addTarget(self, action: #selector(addRequestAction(sender:)), for: .touchUpInside)
                cell.addBtnOut.setTitle("+ Add New Request".localized(), for: .normal)
                cell.addBtnOut.tag = 0
                return cell
            }else{
            if indexPath.row == self.requestSelect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].title ?? "" : self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].title_ar ?? ""
                cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].description ?? "" : self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].description_ar ?? ""
                
                 
                 let dateCal = self.dateF.date(from: self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].created_at ?? "") ?? Date()
                 let str = self.months(from: dateCal)
                 print(str)
                  cell.timeLbl.text = "\(str) " + "months ago".localized()
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].title ?? "" : self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].title_ar ?? ""
                //  cell.descLbl.text = self.memberDetailsModel?.data?.member?.requests?[indexPath.row].description ?? ""
                      
                      let dateCal = self.dateF.date(from: self.profileDetailModel?.data?.profileDetail?.requests?[indexPath.row].created_at ?? "") ?? Date()
                      let str = self.months(from: dateCal)
                      print(str)
                       cell.timeLbl.text = "\(str) " + "months ago".localized()
                return cell
            }
            }
        }else{
            if indexPath.row == self.profileDetailModel?.data?.profileDetail?.offers?.count{
            guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "AddRequestOfferTVC", for: indexPath) as? AddRequestOfferTVC else { return UITableViewCell() }
                cell.addBtnOut.tag = 1
                cell.addBtnOut.addTarget(self, action: #selector(addRequestAction(sender:)), for: .touchUpInside)
                cell.addBtnOut.setTitle("+ Add New Offer".localized(), for: .normal)
                return cell
            }else{
            if indexPath.row == self.offerselect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].title ?? "" : self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].title_ar ?? ""
                cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].description ?? "" : self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].description_ar ?? ""
                
                let dateCal = self.dateF.date(from: self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].created_at ?? "") ?? Date()
                let str = self.months(from: dateCal)
                print(str)
                 cell.timeLbl.text = "\(str) " + "months ago".localized()
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].title ?? "" : self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].title_ar ?? ""
                //  cell.descLbl.text = self.memberDetailsModel?.data?.member?.requests?[indexPath.row].description ?? ""
                      
                      let dateCal = self.dateF.date(from: self.profileDetailModel?.data?.profileDetail?.offers?[indexPath.row].created_at ?? "") ?? Date()
                      let str = self.months(from: dateCal)
                      print(str)
                       cell.timeLbl.text = "\(str) " + "months ago".localized()
                return cell
            }
            }
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selection == 2 {
            if indexPath.row == self.profileDetailModel?.data?.profileDetail?.requests?.count {
                return 70
            }else{
                return UITableView.automaticDimension
            }
        }
        else if self.selection == 3{
            if indexPath.row == self.profileDetailModel?.data?.profileDetail?.offers?.count{
                return 70
            }else{
                return UITableView.automaticDimension
            }
        }
        else{
        return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selection == 2{
            self.requestSelect = indexPath.row
        }else if self.selection == 3{
            self.offerselect = indexPath.row
        }
     //   self.mainTableView.reloadData()
        UIView.animate(withDuration: 1.0) {
                 self.mainTableBottomCont.isActive = true
                 self.whoWeAreBottomConst.isActive = false
                 self.mainTableView.isHidden = false
                 self.whoWeAreView.isHidden = true
                        self.mainTableViewHeightConst.constant = CGFloat.greatestFiniteMagnitude
                        self.mainTableView.reloadData()
            self.mainTableView.reloadSections([0], with: .automatic)
                        self.mainTableView.layoutIfNeeded()
                        self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                        self.mainScrollView.layoutIfNeeded()
                    }
    }
    
    func months(from date: Date) -> Int {
              return Calendar.current.dateComponents([.month], from: date, to: Date()).month ?? 0
          }
}
