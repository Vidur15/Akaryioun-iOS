//
//  WhoWeAreVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class WhoWeAreVC: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    
    var memberDetailsModel : MemberDetailsModel?
    
    var sender : MemberDetailsMainVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getMemberDetailsApi()
        // Do any additional setup after loading the view.
    }
    
    func getMemberDetailsApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.memberDetails + "?id=\(self.sender?.idToSend ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                    
                    //guard self != nil else { return }
                    CommonUtils.showHudWithNoInteraction(show: false)
                    if errorType == .requestSuccess {
                        let dicResponse = kSharedInstance.getDictionary(result)
                        let statusCodes = Int.getInt(statusCode)
                        switch statusCodes {
                        case 200:
                            if dicResponse["success"] as? Bool ?? false{
                               self.memberDetailsModel = MemberDetailsModel.init(dictionary: dicResponse as NSDictionary)
                                
                                self.mainLbl.text = self.memberDetailsModel?.data?.member?.info?.who_we_are ?? ""
        //                     print(self.propertyModel?.data?.property?.data?.count,"COUNT")
                          //      self.mainTableView.reloadData()
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
