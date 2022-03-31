//
//  LoginVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class LoginVC: UIViewController {

    @IBOutlet weak var mobileTextF: UITextField!
    @IBOutlet weak var signupLoginLbl: UILabel!
    @IBOutlet weak var signupBtnOut: UIButton!
    
    @IBOutlet weak var changeTextBtn: UIButton!
    @IBOutlet weak var mobileView: UIView!
    var sender : MainHomeScreenVC?
    
    var selected = "login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.setStatusBarColor()
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        self.mobileView.drawShadowwithCornerWithradius(radius: 22.5)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func entryBtnAction(_ sender: UIButton) {
        
        if self.mobileTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter mobile number")
            return
        }else{
            if self.selected == "login"{
                self.hitLoginApi()
            }else{
                self.hitSignupApi()
            }
        }
    }
    
    func hitLoginApi(){
        let params : [String : Any] = ["mobile_number" : self.mobileTextF.text ?? ""]
                   
                   TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.login, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                       
                       //guard self != nil else { return }
                       CommonUtils.showHudWithNoInteraction(show: false)
                       if errorType == .requestSuccess {
                           let dicResponse = kSharedInstance.getDictionary(result)
                           let statusCodes = Int.getInt(statusCode)
                           switch statusCodes {
                           case 200:
                               if dicResponse["success"] as? Bool ?? false{
                          self.dismiss(animated: true, completion: nil)
                             guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPVC" ) as? VerifyOTPVC  else { return }
                               vc.modalPresentationStyle = .overFullScreen
                               vc.modalTransitionStyle = .coverVertical
                                  vc.mobile = self.mobileTextF.text ?? ""
                                  vc.sender = self.sender
                               //  vc.meetUpModel = self.meetUpModel
                             self.sender?.present(vc, animated: true, completion: nil)
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
    
    
    
    func hitSignupApi(){
        let params : [String : Any] = ["mobile_number" : self.mobileTextF.text ?? ""]
             
             TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.signup, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                    self.dismiss(animated: true, completion: nil)
                       guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPVC" ) as? VerifyOTPVC  else { return }
                         vc.modalPresentationStyle = .overFullScreen
                         vc.modalTransitionStyle = .coverVertical
                            vc.mobile = self.mobileTextF.text ?? ""
                            vc.sender = self.sender
                         //  vc.meetUpModel = self.meetUpModel
                       self.sender?.present(vc, animated: true, completion: nil)
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
    
    
    @IBAction func signupBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.signupLoginLbl.text = "Sign Up"
            self.changeTextBtn.setTitle("Already have an account? Log In", for: .normal)
            self.signupBtnOut.setTitle("Signup", for: .normal)
             self.selected = "signup"
        }else{
            self.selected = "login"
            self.signupLoginLbl.text = "Log In"
            self.changeTextBtn.setTitle("Don't have an account? Sign Up", for: .normal)
            self.signupBtnOut.setTitle("Log In", for: .normal)
        }
        self.changeTextBtn.setTitleColor(#colorLiteral(red: 0.134485513, green: 0.4705364108, blue: 0.7034772038, alpha: 1), for: .normal)
    }
}
