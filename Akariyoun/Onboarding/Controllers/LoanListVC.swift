//
//  LoanListVC.swift
//  Akariyoun
//
//  Created by vidur on 07/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class LoanListVC: UIViewController {
    
    @IBOutlet weak var topLbl: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    var isFrom = "govt"
    
    var loanModel : LoanModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        if self.isFrom == "govt"{
            self.topLbl.text = "Government Loans".localized()
            self.getNewsListApi()
        }else{
            self.topLbl.text = "Private Loans".localized()
            self.getPrivateLoanList()
        }
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "LoanTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "LoanTVC")
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        // Do any additional setup after loading the view.
    }
    
    func getNewsListApi(){
      
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.governmentLoans, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             
             //guard self != nil else { return }
             CommonUtils.showHudWithNoInteraction(show: false)
             if errorType == .requestSuccess {
                 let dicResponse = kSharedInstance.getDictionary(result)
                 let statusCodes = Int.getInt(statusCode)
                 switch statusCodes {
                 case 200:
                     if dicResponse["success"] as? Bool ?? false{
                        self.loanModel = LoanModel.init(dictionary: dicResponse as NSDictionary)
                        self.mainTableView.reloadData()
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
    
    func getPrivateLoanList(){
      
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.corporateLoans, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             
             //guard self != nil else { return }
             CommonUtils.showHudWithNoInteraction(show: false)
             if errorType == .requestSuccess {
                 let dicResponse = kSharedInstance.getDictionary(result)
                 let statusCodes = Int.getInt(statusCode)
                 switch statusCodes {
                 case 200:
                     if dicResponse["success"] as? Bool ?? false{
                        self.loanModel = LoanModel.init(dictionary: dicResponse as NSDictionary)
                        self.mainTableView.reloadData()
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

extension LoanListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFrom == "govt"{
            return self.loanModel?.data?.government_loans?.data?.count ?? 0
        }else{
            return self.loanModel?.data?.corporate_loans?.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "LoanTVC",
                                                                for: indexPath) as? LoanTVC else { return UITableViewCell() }
        if self.isFrom == "govt"{
        cell.mainImageView.downlodeImage(serviceurl: self.loanModel?.data?.government_loans?.data?[indexPath.row].image ?? "", placeHolder: UIImage.init(named: "Logo"))
        }else{
            cell.mainImageView.downlodeImage(serviceurl: self.loanModel?.data?.corporate_loans?.data?[indexPath.row].image ?? "", placeHolder: UIImage.init(named: "Logo"))
        }
         cell.selectionStyle = .none
        cell.openLinkBtnOut.tag = indexPath.row
        cell.openLinkBtnOut.addTarget(self, action: #selector(openLink(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func openLink(sender : UIButton){
        var urlStr = ""
        if self.isFrom == "govt"{
            urlStr = self.loanModel?.data?.government_loans?.data?[sender.tag].link ?? ""
        }else{
            urlStr = self.loanModel?.data?.corporate_loans?.data?[sender.tag].link ?? ""
        }
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
