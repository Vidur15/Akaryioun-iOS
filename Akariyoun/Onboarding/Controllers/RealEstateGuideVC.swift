//
//  RealEstateGuideVC.swift
//  Akariyoun
//
//  Created by vidur on 29/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit

class RealEstateGuideVC: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var searchTextF: UITextField!
      @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var isSearch = false
    
    var directoryModel : DirectoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
               self.mainTableView.dataSource = self
               let nib = UINib(nibName: "RealEstateGuideTVC", bundle: Bundle.main)
               self.mainTableView.register(nib, forCellReuseIdentifier: "RealEstateGuideTVC")
        
        self.searchTextF.delegate = self
        self.searchTextF.returnKeyType = .search
        self.searchTextF.setLeftPaddingPoints(16)
        
        self.getDirectoryList()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.getDirectoryList()
           return false
       }
    
    @IBAction func crossSearchAction(_ sender: UIButton) {
           self.isSearch = false
           self.searchView.isHidden = true
       }
       
       @IBAction func searchBtnAction(_ sender: UIButton) {
           self.isSearch = true
       self.searchView.isHidden = false
       }
    
    
    func getDirectoryList(){
        var url = ""
         if self.isSearch{
           url = (ServiceName.directories + "&search=\(self.searchTextF.text ?? "")").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
         }else{
             url = ServiceName.directories
         }
         TANetworkManager.sharedInstance.requestApi(withServiceName: url, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             
             //guard self != nil else { return }
             CommonUtils.showHudWithNoInteraction(show: false)
             if errorType == .requestSuccess {
                 let dicResponse = kSharedInstance.getDictionary(result)
                 let statusCodes = Int.getInt(statusCode)
                 switch statusCodes {
                 case 200:
                     if dicResponse["success"] as? Bool ?? false{
                         self.directoryModel = DirectoryModel.init(dictionary: dicResponse as NSDictionary)
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

extension RealEstateGuideVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.directoryModel?.data?.directories?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "RealEstateGuideTVC",
                for: indexPath) as? RealEstateGuideTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.locationLbl.text = self.directoryModel?.data?.directories?.data?[indexPath.row].office_location ?? ""
        cell.areaNameLbl.text = self.directoryModel?.data?.directories?.data?[indexPath.row].office_area_name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RealEstateContactVC" ) as? RealEstateContactVC  else { return }
          vc.modalPresentationStyle = .overFullScreen
          vc.modalTransitionStyle = .coverVertical
        //  vc.sender = self
          
          //  vc.meetUpModel = self.meetUpModel
        self.present(vc, animated: true, completion: nil)
    }
}
