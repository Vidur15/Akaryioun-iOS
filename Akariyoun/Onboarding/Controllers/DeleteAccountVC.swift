//
//  DeleteAccountVC.swift
//  Akariyoun
//
//  Created by vidur on 11/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import SVPinView

class DeleteAccountVC: UIViewController {

    
    @IBOutlet weak var pinView: SVPinView!
    
    var otpString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         self.pinView.style = .box
        self.setStatusBarColor()
        self.getOtpOnPhone()
        // Do any additional setup after loading the view.
    }
    
    
    func getOtpOnPhone(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.deleteAccountOtp, requestMethod: .POST, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let str = dataDict["mobile_number"] as? String ?? ""
                            showAlertMessage.alert(message: "OTP Sent On this mobile number \(str)")
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
    
    @IBAction func deleteAccountAction(_ sender: UIButton) {
    self.otpString = String.getString(self.pinView.getPin())
    if Int.getInt(otpString.count) != 6 {
        CommonUtils.showToast(message: "Please enter otp")
        return
    }else{
        self.hitDeleteAccountApi()
       // self.hitVerifyOtpApi()
    }
    }
    
    func hitDeleteAccountApi(){
        
        let param = ["otp" : self.otpString]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.deleteAccount, requestMethod: .POST, requestParameters: param, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                      
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
                                showAlertMessage.alert1(message: "Account has been deleted", sender: self)
                                
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
    
}
