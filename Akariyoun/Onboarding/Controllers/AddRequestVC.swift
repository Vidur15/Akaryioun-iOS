//
//  AddRequestVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class AddRequestVC: UIViewController {
    
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sendRequestView: UIView!
    
    @IBOutlet weak var firstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.firstView.drawShadowwithCornerWithradius(radius: 22.5)
        
        self.sendRequestView.drawShadowwithCornerWithradius(radius: 22.5)
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        self.titleTextField.setLeftPaddingPoints(16)
        self.descTextView.addPadding(to: self.descTextView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addRequestAction(_ sender: UIButton) {
        if self.titleTextField.text?.count == 0{
            CommonUtils.showToast(message: "Please enter title")
            return
        }else if self.descTextView.text.count == 0{
            CommonUtils.showToast(message: "Please enter description")
            return
        }else{
            self.hitAddrequestApi()
        }
    }
    
    func hitAddrequestApi(){
        let params : [String : Any] = ["type" : "1","title" : self.titleTextField.text ?? "","description" : self.descTextView.text ?? ""]
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.addRequest, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            //guard self != nil else { return }
            CommonUtils.showHudWithNoInteraction(show: false)
            if errorType == .requestSuccess {
                let dicResponse = kSharedInstance.getDictionary(result)
                let statusCodes = Int.getInt(statusCode)
                switch statusCodes {
                case 200:
                    if dicResponse["success"] as? Bool ?? false{
                        self.navigationController?.popViewController(animated: true)
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
