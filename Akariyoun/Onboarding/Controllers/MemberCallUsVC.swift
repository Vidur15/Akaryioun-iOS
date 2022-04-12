//
//  MemberCallUsVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MemberCallUsVC: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var memberDetailsModel : MemberDetailsModel?
    
    var sender : MemberDetailsMainVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "MemberRealEstateTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "MemberRealEstateTVC")
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
                                self.mainTableView.reloadData()
           //                     self.mainLbl.text = self.memberDetailsModel?.data?.member?.info?.who_we_are ?? ""
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

extension MemberCallUsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberDetailsModel?.data?.member?.real_state?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "MemberRealEstateTVC", for: indexPath) as? MemberRealEstateTVC else { return UITableViewCell() }
        cell.selectionStyle = .none

        cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].title ?? "" : self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].title_ar ?? ""
//        cell.descLbl.text = self.propertyModel?.data?.property?.data?[indexPath.row].description ?? ""
       if self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].images?.count > 0{
            cell.mainImageView.downlodeImage(serviceurl: self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].images?[0].name ?? "", placeHolder: UIImage.init(named: "Logo"))
        }
        
        cell.priceBtnOut.setTitle("Asking for \( self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].price ?? 0) SAR", for: .normal)
      //  cell.sectoreLbl.text = self.memberDetailsModel?.data?.member?.real_state?[indexPath.row].
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
