//
//  VerifyOTPVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController
import SVPinView

class VerifyOTPVC: UIViewController {
    
    @IBOutlet weak var resendBtnOut: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBOutlet weak var pinView: SVPinView!
    
    var otpString = ""
      
    
    var mobile = ""
       
       var timer = Timer()
       
       var timeCount = 60
    
    var sender : MainHomeScreenVC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
         self.pinView.style = .box
        
        self.timerLbl.isHidden = false
        self.resendBtnOut.isUserInteractionEnabled = false
        self.timer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: RunLoop.Mode.default)
        
        self.resendBtnOut.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @objc func timerAction() {
          if self.timeCount > 0{
              self.timeCount -= 1
              let tup = self.secondsToHoursMinutesSeconds(seconds: self.timeCount)
              
              if timeCount < 10{
                  self.timerLbl.text = "0\(tup.1):0\(tup.2)"
              }else{
                  self.timerLbl.text = "0\(tup.1):\(tup.2)"
              }
              
          }else{
              self.timerLbl.isHidden = true
              //  self.didntRecieveLbl.isHidden = false
              self.resendBtnOut.isHidden = false
              timeCount = 60
              self.resendBtnOut.isUserInteractionEnabled = true
              self.timer.invalidate()
              //  self.timer = nil
          }
      }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
           return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
       }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resendBtnAction(_ sender: UIButton) {
        self.resendOtpApi()
    }
    
    @IBAction func verifyBtnAction(_ sender: UIButton) {
    self.otpString = String.getString(self.pinView.getPin())
    if Int.getInt(otpString.count) != 6 {
        CommonUtils.showToast(message: "Please enter otp")
        return
    }else{
        self.hitVerifyOtpApi()
    }
    }
    
    
    func resendOtpApi(){
        self.resendBtnOut.isHidden = true
        let params : [String : Any] = ["mobile_number" : self.mobile]
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.login, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                  
                  //guard self != nil else { return }
                  CommonUtils.showHudWithNoInteraction(show: false)
                  if errorType == .requestSuccess {
                      let dicResponse = kSharedInstance.getDictionary(result)
                      let statusCodes = Int.getInt(statusCode)
                      switch statusCodes {
                      case 200:
                          if dicResponse["token"] as? String != ""{
                              self.resendBtnOut.isUserInteractionEnabled = false
                              self.timer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
                              self.timerLbl.isHidden = false
                              RunLoop.main.add(self.timer, forMode: RunLoop.Mode.default)
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
    
    
    func hitVerifyOtpApi(){
        
        let dict = ["mobile_number" : self.mobile,"otp" : self.otpString]
        
             TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.verifyOtp, requestMethod: .POST, requestParameters: dict, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                        if dicResponse["message"] as? String == "Success"{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            
                            let token = dataDict["token"] as? String ?? ""
                            let userDict = kSharedInstance.getDictionary(dataDict["user"])
                            kSharedUserDefaults.setLoggedInAccessToken(loggedInAccessToken: token)
                            kSharedUserDefaults.setUserLoggedIn(userLoggedIn: true)
                            kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userDict)
                            
                            self.dismiss(animated: true, completion: nil)
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
