//
//  ContactUsVC.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var subjectTextF: UITextField!
    @IBOutlet weak var mobileTextF: UITextField!
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var subjectView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameView.drawShadowwithCornerWithradius(radius: 22.5)
        self.emailView.drawShadowwithCornerWithradius(radius: 22.5)
        self.numberView.drawShadowwithCornerWithradius(radius: 22.5)
        self.subjectView.drawShadowwithCornerWithradius(radius: 22.5)
        self.messageView.drawShadowwithCornerWithradius(radius: 22.5)
        
        self.nameTextF.setLeftPaddingPoints(16)
        self.emailTextF.setLeftPaddingPoints(16)
        self.mobileTextF.setLeftPaddingPoints(16)
        self.subjectTextF.setLeftPaddingPoints(16)
        self.messageTextView.addPadding(to: self.messageTextView)
        
        self.setStatusBarColor()
        self.getContactUsApi()
        // Do any additional setup after loading the view.
    }
    
    
    func getContactUsApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.contactUs, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let privacyDict = kSharedInstance.getDictionary(dataDict["contactus"])
                            self.addressLbl.text = privacyDict["address"] as? String ?? ""
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

    
    
    @IBAction func sendBtnAction(_ sender: UIButton) {
        if self.nameTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter name")
            return
        }else if self.emailTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter email")
                       return
        }else if self.mobileTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter mobile number")
                       return
        }else if self.subjectTextF.text?.count == 0{
            CommonUtils.showToast(message: "Please enter subject")
                       return
        }else if self.messageTextView.text.count == 0{
            CommonUtils.showToast(message: "Please enter message")
                       return
        }else{
            self.hitContactUsApi()
        }
    }
    
    func hitContactUsApi(){
        let params : [String : Any] = ["name" : self.nameTextF.text ?? "","email" : self.emailTextF.text ?? "","mobile" : self.mobileTextF.text ?? "","subject" : self.subjectTextF.text ?? "","message" : self.messageTextView.text ?? ""]
                    
                    TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.postcontactUs, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                        
                        //guard self != nil else { return }
                        CommonUtils.showHudWithNoInteraction(show: false)
                        if errorType == .requestSuccess {
                            let dicResponse = kSharedInstance.getDictionary(result)
                            let statusCodes = Int.getInt(statusCode)
                            switch statusCodes {
                            case 200:
                                if dicResponse["success"] as? Bool ?? false{
                                  showAlertMessage.alert1(message: "Query Submitted", sender: self)
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
