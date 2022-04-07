//
//  RealEstateVC.swift
//  Akariyoun
//
//  Created by vidur on 24/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class RealEstateVC: UIViewController {
    
    @IBOutlet weak var backBtnOut: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var isFrom = false
    
    var propertyModel : PropertyListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "RealEstateTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "RealEstateTVC")
        
        if self.isFrom{
            if let drawerController = navigationController?.parent as? KYDrawerController {
                drawerController.screenEdgePanGestureEnabled = false
            }
            self.backBtnOut.setImage(UIImage.init(named: "arrow-back"), for: .normal)
            self.backBtnOut.backgroundColor = #colorLiteral(red: 0.134485513, green: 0.4705364108, blue: 0.7034772038, alpha: 1)
        }
        
        self.getPropertyListApi()
        // Do any additional setup after loading the view.
    }
    
    
    func getPropertyListApi(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.propertyList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            //guard self != nil else { return }
            CommonUtils.showHudWithNoInteraction(show: false)
            if errorType == .requestSuccess {
                let dicResponse = kSharedInstance.getDictionary(result)
                let statusCodes = Int.getInt(statusCode)
                switch statusCodes {
                case 200:
                    if dicResponse["success"] as? Bool ?? false{
                        self.propertyModel = PropertyListModel.init(dictionary: dicResponse as NSDictionary)
                     print(self.propertyModel?.data?.property?.data?.count,"COUNT")
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
    
    
    @IBAction func drawerAction(_ sender: UIButton) {
        if self.isFrom{
            self.navigationController?.popViewController(animated: true)
        }else{
            DispatchQueue.main.async {
                if let drawerController = self.navigationController?.parent as? KYDrawerController {
                    drawerController.drawerWidth = (kScreenWidth - 100)
                    
                    drawerController.drawerDirection = .left
                    drawerController.setDrawerState(.opened, animated: true)
                }
            }
        }
    }
}

extension RealEstateVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyModel?.data?.property?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RealEstateTVC", for: indexPath) as? RealEstateTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.dateLbl.text = "Posted on : \(self.propertyModel?.data?.property?.data?[indexPath.row].created_at ?? "")"
        cell.headingLbl.text = self.propertyModel?.data?.property?.data?[indexPath.row].title ?? ""
        cell.descLbl.text = self.propertyModel?.data?.property?.data?[indexPath.row].description ?? ""
        if self.propertyModel?.data?.property?.data?[indexPath.row].images?.count > 0{
            cell.mainImageView.downlodeImage(serviceurl: self.propertyModel?.data?.property?.data?[indexPath.row].images?[0].name ?? "", placeHolder: UIImage.init(named: "Logo"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailsVC" ) as? PropertyDetailsVC  else { return }
        vc.idToSend = self.propertyModel?.data?.property?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagePopVC" ) as? MessagePopVC  else { return }
        //           vc.modalPresentationStyle = .overFullScreen
        //           vc.modalTransitionStyle = .coverVertical
        //        //   vc.sender = self
        //
        //           //  vc.meetUpModel = self.meetUpModel
        //           self.present(vc, animated: true, completion: nil)
    }
}
