//
//  ViewController.swift
//  Akariyoun
//
//  Created by vidur on 22/02/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class ViewController: UIViewController {
    
    @IBOutlet weak var backBtnOut: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var isFrom = false
    
    var requestModel : RequestsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "RequestsTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "RequestsTVC")
        
        if self.isFrom{
                   if let drawerController = navigationController?.parent as? KYDrawerController {
                              drawerController.screenEdgePanGestureEnabled = false
                          }
                   self.backBtnOut.setImage(UIImage.init(named: "arrow-back"), for: .normal)
                   self.backBtnOut.backgroundColor = #colorLiteral(red: 0.134485513, green: 0.4705364108, blue: 0.7034772038, alpha: 1)
               }
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           tabBarItem.title = "Requests".localized()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getRequestsList()
    }
    
    func getRequestsList(){
       
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.requestList, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            //guard self != nil else { return }
            CommonUtils.showHudWithNoInteraction(show: false)
            if errorType == .requestSuccess {
                let dicResponse = kSharedInstance.getDictionary(result)
                let statusCodes = Int.getInt(statusCode)
                switch statusCodes {
                case 200:
                    if dicResponse["success"] as? Bool ?? false{
                       self.requestModel = RequestsModel.init(dictionary: dicResponse as NSDictionary)
//                     print(self.propertyModel?.data?.property?.data?.count,"COUNT")
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
    
    
   @IBAction func addRequestAction(_ sender: UIButton) {
   guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRequestVC" ) as? AddRequestVC  else { return }
    vc.isFrom = 1
            self.navigationController?.pushViewController(vc, animated: true)
   }
    
    @IBAction func drawerAction(_ sender: UIButton) {
        if self.isFrom{
            self.navigationController?.popViewController(animated: true)
        }else{
          DispatchQueue.main.async {
                     if let drawerController = self.navigationController?.parent as? KYDrawerController {
                         drawerController.drawerWidth = (kScreenWidth - 100)
                        
                         drawerController.drawerDirection = kSharedUserDefaults.getLanguageName() == "en" ? .left : .right
                         drawerController.setDrawerState(.opened, animated: true)
                     }
                 }
        }
      }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requestModel?.data?.requests?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RequestsTVC", for: indexPath) as? RequestsTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.headingLbl.text =  self.requestModel?.data?.requests?.data?[indexPath.row].title ?? ""
        cell.descLbl.text =  self.requestModel?.data?.requests?.data?[indexPath.row].description ?? ""
        cell.daeLbl.text = "Posted on :".localized() + "\(self.requestModel?.data?.requests?.data?[indexPath.row].created_at ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RequestDetailsVC" ) as? RequestDetailsVC  else { return }
        let obj = self.requestModel?.data?.requests?.data?[indexPath.row]
        vc.obj = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
