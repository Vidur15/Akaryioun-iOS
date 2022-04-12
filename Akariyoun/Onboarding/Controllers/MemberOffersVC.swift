//
//  MemberOffersVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class MemberOffersVC: UIViewController {

    @IBOutlet weak var mainTabkeView: UITableView!
    
    var select = 0
    var memberDetailsModel : MemberDetailsModel?
    
    var sender : MemberDetailsMainVC?
    
     var dateF = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTabkeView.delegate = self
                                 self.mainTabkeView.dataSource = self
                                 let nib = UINib(nibName: "CommonCollapseTVC", bundle: Bundle.main)
                                 self.mainTabkeView.register(nib, forCellReuseIdentifier: "CommonCollapseTVC")
                          let nib1 = UINib(nibName: "CommonExpandTVC", bundle: Bundle.main)
                          self.mainTabkeView.register(nib1, forCellReuseIdentifier: "CommonExpandTVC")
            
            self.dateF.dateFormat = "dd MMM, yyyy hh:mm a"
        
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
                                self.mainTabkeView.reloadData()
                                self.mainTabkeView.reloadSections([0], with: .automatic)
                          //      self.mainLbl.text = self.memberDetailsModel?.data?.member?.info?.who_we_are ?? ""
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
extension MemberOffersVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberDetailsModel?.data?.member?.offers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.select{
            guard let cell = self.mainTabkeView.dequeueReusableCell(withIdentifier: "CommonExpandTVC", for: indexPath) as? CommonExpandTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.memberDetailsModel?.data?.member?.offers?[indexPath.row].title ?? "" : self.memberDetailsModel?.data?.member?.offers?[indexPath.row].title_ar ?? ""
            cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.memberDetailsModel?.data?.member?.offers?[indexPath.row].description ?? "" : self.memberDetailsModel?.data?.member?.offers?[indexPath.row].description_ar ?? ""
            
            let dateCal = self.dateF.date(from: self.memberDetailsModel?.data?.member?.offers?[indexPath.row].created_at ?? "") ?? Date()
            print(dateCal,"CHECK VIDUR")
            let str = self.months(from: dateCal)
            print(str)
             cell.timeLbl.text = "\(str) " + "months ago".localized()
            
          //  cell.timeLbl.text = self.memberDetailsModel?.data?.member?.requests?[indexPath.row].created_at ?? ""
            return cell
        }else{
        guard let cell = self.mainTabkeView.dequeueReusableCell(withIdentifier: "CommonCollapseTVC", for: indexPath) as? CommonCollapseTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
            cell.mainLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.memberDetailsModel?.data?.member?.offers?[indexPath.row].title ?? "" : self.memberDetailsModel?.data?.member?.offers?[indexPath.row].title_ar ?? ""
      //  cell.descLbl.text = self.memberDetailsModel?.data?.member?.requests?[indexPath.row].description ?? ""
            
            let dateCal = self.dateF.date(from: self.memberDetailsModel?.data?.member?.offers?[indexPath.row].created_at ?? "") ?? Date()
            print(dateCal,"CHECK VIDUR")
            let str = self.months(from: dateCal)
            print(str)
             cell.timeLbl.text = "\(str) " + "months ago".localized()
            
     //   cell.timeLbl.text = self.memberDetailsModel?.data?.member?.requests?[indexPath.row].created_at ?? ""
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select = indexPath.row
        self.mainTabkeView.reloadData()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func months(from date: Date) -> Int {
              return Calendar.current.dateComponents([.month], from: date, to: Date()).month ?? 0
          }
}
