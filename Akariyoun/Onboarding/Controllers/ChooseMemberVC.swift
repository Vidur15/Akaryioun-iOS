//
//  ChooseMemberVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class ChooseMemberVC: UIViewController {

   
    @IBOutlet weak var mainTableView: UITableView!
    
    var memberModel : MemberModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
               self.mainTableView.dataSource = self
               let nib = UINib(nibName: "ChooseMemberTVC", bundle: Bundle.main)
               self.mainTableView.register(nib, forCellReuseIdentifier: "ChooseMemberTVC")
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        self.getMemberList()
        // Do any additional setup after loading the view.
    }
    
    
        func getMemberList(){
           
            TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.memberList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                
                //guard self != nil else { return }
                CommonUtils.showHudWithNoInteraction(show: false)
                if errorType == .requestSuccess {
                    let dicResponse = kSharedInstance.getDictionary(result)
                    let statusCodes = Int.getInt(statusCode)
                    switch statusCodes {
                    case 200:
                        if dicResponse["success"] as? Bool ?? false{
                        self.memberModel = MemberModel.init(dictionary: dicResponse as NSDictionary)
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
extension ChooseMemberVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberModel?.data?.member?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "ChooseMemberTVC", for: indexPath) as? ChooseMemberTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainLbl.text = "\(self.memberModel?.data?.member?.data?[indexPath.row].first_name ?? "") \(self.memberModel?.data?.member?.data?[indexPath.row].last_name ?? "")"
        cell.descLbl.text = "Member Since : "
        cell.mainImageView.downlodeImage(serviceurl: self.memberModel?.data?.member?.data?[indexPath.row].profile_pic ?? "", placeHolder: UIImage.init(named: "Logo"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRequestVC" ) as? AddRequestVC  else { return }
          self.navigationController?.pushViewController(vc, animated: true)
    }
}
