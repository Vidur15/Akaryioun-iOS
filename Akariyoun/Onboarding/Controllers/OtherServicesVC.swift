//
//  OtherServicesVC.swift
//  Akariyoun
//
//  Created by vidur on 11/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class OtherServicesVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var servicesArr = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
                             self.mainTableView.dataSource = self
                             let nib = UINib(nibName: "OtherServicesTVC", bundle: Bundle.main)
                             self.mainTableView.register(nib, forCellReuseIdentifier: "OtherServicesTVC")
        
        self.getOtherServices()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getOtherServices(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.otherServices, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 
                 //guard self != nil else { return }
                 CommonUtils.showHudWithNoInteraction(show: false)
                 if errorType == .requestSuccess {
                     let dicResponse = kSharedInstance.getDictionary(result)
                     let statusCodes = Int.getInt(statusCode)
                     switch statusCodes {
                     case 200:
                         if dicResponse["success"] as? Bool ?? false{
                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
                            let memberDict = kSharedInstance.getDictionary(dataDict["member"])
                            let arr = kSharedInstance.getDictionaryArray(withDictionary: memberDict["data"])
                            self.servicesArr =  arr.map({Member.init(dictionary: $0)})
                            self.mainTableView.reloadData()
                         //   self.mainLbl.text = privacyDict["content"] as? String ?? ""
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

extension OtherServicesVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servicesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "OtherServicesTVC", for: indexPath) as? OtherServicesTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainImageView.downlodeImage(serviceurl: self.servicesArr[indexPath.row].profile_pic ?? "", placeHolder: UIImage.init(named: "Profile"))
        cell.nameLbl.text = "\(self.servicesArr[indexPath.row].first_name ?? "") \(self.servicesArr[indexPath.row].last_name ?? "")"
        cell.emailLbl.text = self.servicesArr[indexPath.row].email ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
