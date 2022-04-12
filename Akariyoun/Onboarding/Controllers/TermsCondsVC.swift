//
//  TermsCondsVC.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class TermsCondsVC: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    
    var isfrom = "terms"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        if self.isfrom == "terms"{
            self.topLbl.text = "Terms & Conditions".localized()
            self.getTermsConds()
        }else if self.isfrom == "privacy"{
            self.topLbl.text = "Privacy Policy".localized()
            self.getPrivacyPolicy()
        }else if self.isfrom == "about"{
            self.topLbl.text = "About Us".localized()
            self.getAboutUs()
        }
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
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
                            self.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  privacyDict["content"] as? String ?? "" : privacyDict["content_ar"] as? String ?? ""
                            
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
                            self.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  privacyDict["content"] as? String ?? "" : privacyDict["content_ar"] as? String ?? ""
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
                             self.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  privacyDict["content"] as? String ?? "" : privacyDict["content_ar"] as? String ?? ""
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
