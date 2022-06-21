//
//  NewsVC.swift
//  Akariyoun
//
//  Created by vidur on 06/04/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class NewsVC: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var searchTextF: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var newsModel : NewsModel?
    
    var isSearch = false
    
    var geo : Geometry?
    
    @IBOutlet weak var backBtnOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "NewsTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "NewsTVC")
        
        self.searchTextF.delegate = self
        self.searchTextF.returnKeyType = .search
        self.searchTextF.setLeftPaddingPoints(16)
        self.searchTextF.textAlignment = kSharedUserDefaults.getLanguageName() == "en" ? .left : .right
        self.getNewsListApi()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        self.backBtnOut.setImage(kSharedUserDefaults.getLanguageName() == "en" ? UIImage.init(named: "arrow-back") : UIImage.init(named: "Back arrow"), for: .normal)
      
      //  self.searchTextF.textAlignment = kSharedUserDefaults.getLanguageName() == "en"
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.getNewsListApi()
        return false
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crossSearchAction(_ sender: UIButton) {
        self.isSearch = false
        self.searchView.isHidden = true
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        self.isSearch = true
    self.searchView.isHidden = false
    }
    
    
    func getNewsListApi(){
       var url = ""
        if self.isSearch{
           url = (ServiceName.newsList + "&search=\(self.searchTextF.text ?? "")").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }else{
            url = ServiceName.newsList
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
                        self.newsModel = NewsModel.init(dictionary: dicResponse as NSDictionary)
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
    
}

extension NewsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsModel?.data?.news?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "NewsTVC",
                                                                for: indexPath) as? NewsTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.mainImageView.downlodeImage(serviceurl: self.newsModel?.data?.news?.data?[indexPath.row].image ?? "", placeHolder: UIImage.init(named: "Logo"))
        cell.headingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.newsModel?.data?.news?.data?[indexPath.row].title ?? "" : self.newsModel?.data?.news?.data?[indexPath.row].title_ar ?? ""
        cell.descLbl.text = kSharedUserDefaults.getLanguageName() == "en" ?  self.newsModel?.data?.news?.data?[indexPath.row].description ?? "" : self.newsModel?.data?.news?.data?[indexPath.row].description_ar ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:
         "NewsDetailsVC" ) as? NewsDetailsVC  else { return }
        vc.idToSend = self.newsModel?.data?.news?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
