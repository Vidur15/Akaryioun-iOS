//
//  TermsCondsVC.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class TermsCondsVC: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    
    var isfrom = "terms"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        if self.isfrom == "terms"{
            self.topLbl.text = "Terms & Conditions"
            self.getTermsConds()
        }else if self.isfrom == "privacy"{
            self.topLbl.text = "Privacy Policy"
            self.getPrivacyPolicy()
        }else if self.isfrom == "about"{
            self.topLbl.text = "About Us"
            self.getAboutUs()
        }
        // Do any additional setup after loading the view.
    }
    
    func getPrivacyPolicy(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.privacyPolicy, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let privacyDict = kSharedInstance.getDictionary(dataDict["privacy"])
                            self.mainLbl.text = privacyDict["content"] as? String ?? ""
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
    
    func getTermsConds(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.termsConditions, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let privacyDict = kSharedInstance.getDictionary(dataDict["terms"])
                            self.mainLbl.text = privacyDict["content"] as? String ?? ""
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
    
    func getAboutUs(){
         TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.aboutUs, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                  
                  //guard self != nil else { return }
                  CommonUtils.showHudWithNoInteraction(show: false)
                  if errorType == .requestSuccess {
                      let dicResponse = kSharedInstance.getDictionary(result)
                      let statusCodes = Int.getInt(statusCode)
                      switch statusCodes {
                      case 200:
                          if dicResponse["success"] as? Bool ?? false{
                             let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                             let privacyDict = kSharedInstance.getDictionary(dataDict["about"])
                             self.mainLbl.text = privacyDict["content"] as? String ?? ""
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
