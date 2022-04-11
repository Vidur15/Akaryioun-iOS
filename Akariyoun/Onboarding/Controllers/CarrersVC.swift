//
//  CarrersVC.swift
//  Akariyoun
//
//  Created by vidur on 11/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class CarrersVC: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        self.getCarrers()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCarrers(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.careers, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let privacyDict = kSharedInstance.getDictionary(dataDict["careers"])
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

}
