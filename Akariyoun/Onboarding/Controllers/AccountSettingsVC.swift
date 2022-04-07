//
//  AccountSettingsVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class AccountSettingsVC: UIViewController {
    
    
    @IBOutlet weak var linkedinTextF: UITextField!
    @IBOutlet weak var twitterTextF: UITextField!
    @IBOutlet weak var facebookTextF: UITextField!
    @IBOutlet weak var lastNameTextF: UITextField!
    @IBOutlet weak var firstNameTextF: UITextField!
    @IBOutlet weak var userNameTextF: UITextField!
    
    @IBOutlet weak var emailTextF: UITextField!
    
    @IBOutlet weak var linkedinView: UIView!
    
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var userNameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        self.userNameView.drawShadowwithCornerWithradius(radius: 22.5)
        self.emailView.drawShadowwithCornerWithradius(radius: 22.5)
        self.lastNameView.drawShadowwithCornerWithradius(radius: 22.5)
        self.firstNameView.drawShadowwithCornerWithradius(radius: 22.5)
        self.facebookView.drawShadowwithCornerWithradius(radius: 22.5)
        self.twitterView.drawShadowwithCornerWithradius(radius: 22.5)
        self.linkedinView.drawShadowwithCornerWithradius(radius: 22.5)
        
        self.userNameTextF.setLeftPaddingPoints(16)
        self.emailTextF.setLeftPaddingPoints(16)
        self.firstNameTextF.setLeftPaddingPoints(16)
        self.lastNameTextF.setLeftPaddingPoints(16)
        self.facebookTextF.setLeftPaddingPoints(16)
        self.twitterTextF.setLeftPaddingPoints(16)
        self.linkedinTextF.setLeftPaddingPoints(16)
        self.getUserDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
        if self.userNameTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter username")
            return
        }else if !(self.emailTextF.text?.isEmail() ?? false){
            CommonUtils.showToast(message: "Please enter email")
                       return
        }else if self.firstNameTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter first name")
                       return
        }else if self.lastNameTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter last name")
                       return
        }else if self.facebookTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter facebook id")
                       return
        }else if self.twitterTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter twitter id")
                       return
        }else if self.linkedinTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter linkedin id")
                       return
        }else{
            hitUpdateAccountApi()
        }
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
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let userDict = kSharedInstance.getDictionary(dataDict["profileDetail"])
                            self.userNameTextF.text = userDict["mobile_number"] as? String ?? ""
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
    
    func hitUpdateAccountApi(){
        
        let params : [String : Any] = ["first_name" : self.firstNameTextF.text ?? "","last_name" : self.lastNameTextF.text ?? "","email" : self.emailTextF.text ?? "","facebook" : self.facebookTextF.text ?? "","twitter" : self.twitterTextF.text ?? "","linkedin" : self.linkedinTextF.text ?? ""]
              
              TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.acountSettings, requestMethod: .PUT, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                  
                  //guard self != nil else { return }
                  CommonUtils.showHudWithNoInteraction(show: false)
                  if errorType == .requestSuccess {
                      let dicResponse = kSharedInstance.getDictionary(result)
                      let statusCodes = Int.getInt(statusCode)
                      switch statusCodes {
                      case 200:
                          if dicResponse["success"] as? Bool ?? false{
                            showAlertMessage.alert1(message: "Account Details Updated", sender: self)
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
