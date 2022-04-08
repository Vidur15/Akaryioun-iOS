//
//  ProfileVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
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

        // Do any additional setup after loading the view.
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
            self.animateView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
        }
    }
    
    @IBAction func selectionAction(_ sender: UIButton) {
        self.transformView(sender: sender)
        self.selection = sender.tag
        print(self.selection,"CHECK")
     
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
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableViewHeightConst.constant = self.mainTableView.contentSize.height
                   self.mainScrollView.layoutIfNeeded()
               }
        }
    }
    
    
    @IBAction func saveWhoWeAreAction(_ sender: UIButton) {
        if self.mainTextVew.text.count == 0{
            CommonUtils.showToast(message: "Please enter details about yourself")
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
                                  showAlertMessage.alert(message: "Account Details Updated")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selection == 1{
            return 10
        }else if self.selection == 2{
            return 10
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selection == 1{
            guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "MemberRealEstateTVC",
                                                                    for: indexPath) as? MemberRealEstateTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }else if self.selection == 2{
            if indexPath.row == self.requestSelect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        }else{
            if indexPath.row == self.offerselect{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }else{
                guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selection == 2{
            self.requestSelect = indexPath.row
        }else if self.selection == 3{
            self.offerselect = indexPath.row
        }
        self.mainTableView.reloadData()
    }
}
