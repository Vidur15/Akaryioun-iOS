//
//  SideMenuVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var menuArr = ["Real Estate","Members","Request","Who are we","Call Us","Language"]
    var imageArr = ["property","members","Requests","who are we","Call","2135789_earth_language_planet_icon"]
    
    var boolVal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        let nib = UINib(nibName: "SideMenuTVC", bundle: Bundle.main)
        self.mainTableView.register(nib, forCellReuseIdentifier: "SideMenuTVC")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("check vidur side menu")
        if kSharedUserDefaults.getLoggedInAccessToken() == ""{
            self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Language".localized()]
            self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","2135789_earth_language_planet_icon"]
        }else{
            self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Profile".localized(),"Settings".localized(),"Language".localized()]
            self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","Profile","Setting","2135789_earth_language_planet_icon"]
        }
        self.mainTableView.reloadData()
    }
}


extension SideMenuVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as? SideMenuTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.mainLbl.text = self.menuArr[indexPath.row]
        cell.mainImageView.image = UIImage.init(named: self.imageArr[indexPath.row])
        
        
        if indexPath.row == (self.menuArr.count - 1){
            cell.hideImageView.isHidden = true
        }else{
            cell.hideImageView.isHidden = false
        }
        
        if kSharedUserDefaults.getLoggedInAccessToken() == ""{
            if indexPath.row == 7{
                       cell.dropIcon.isHidden = false
                   }else{
                       cell.dropIcon.isHidden = true
                   }
        }else{
            if indexPath.row == 9{
                       cell.dropIcon.isHidden = false
                   }else{
                       cell.dropIcon.isHidden = true
                   }
        }
        return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    private func pushToVC(identifierName : String, storyboard : UIStoryboard) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
            let vc = storyboard.instantiateViewController(withIdentifier: identifierName)
            
            if let cont = vc as? RealEstateVC{
                cont.isFrom = true
            }
            
            if let cont = vc as? ViewController{
                cont.isFrom = true
            }
            
            if let cont = vc as? TermsCondsVC{
                cont.isfrom = "about"
            }
            
            if identifierName == "ChooseLanguageVC" {
                UserDefaults.standard.set("Menu", forKey: "CameFrom")
                UserDefaults.standard.synchronize()
            }
            if let navVC = drawerController.mainViewController as? UINavigationController {
                navVC.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row,"CHECK VIDUR")
        let checkVal = kSharedUserDefaults.getLoggedInAccessToken() == "" ? 7 : 9
        if indexPath.row == 0{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            pushToVC(identifierName: "RealEstateVC", storyboard: storyboard)
        }
        else if indexPath.row == 1{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            pushToVC(identifierName: "MembersVC", storyboard: storyboard)
        }
        else if indexPath.row == 2{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            pushToVC(identifierName: "ViewController", storyboard: storyboard)
        }
        else if indexPath.row == 3{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            pushToVC(identifierName: "TermsCondsVC", storyboard: storyboard)
        }
        else if indexPath.row == 4{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            pushToVC(identifierName: "ContactUsVC", storyboard: storyboard)
        }
            else if indexPath.row == 5{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "OtherServicesVC", storyboard: storyboard)
            }
            else if indexPath.row == 6{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "CarrersVC", storyboard: storyboard)
            }
           
            
        else if indexPath.row == checkVal{
            self.boolVal = !self.boolVal
            if self.boolVal{
                if kSharedUserDefaults.getLoggedInAccessToken() == ""{
                    self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Language".localized(),"English".localized(),"Arabic".localized()]
                    self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","2135789_earth_language_planet_icon","2135789_earth_language_planet_icon","2135789_earth_language_planet_icon"]
                }else{
                    self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Profile".localized(),"Settings".localized(),"Language".localized(),"English".localized(),"Arabic".localized()]
                    self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","Profile","Setting","2135789_earth_language_planet_icon","2135789_earth_language_planet_icon","2135789_earth_language_planet_icon"]
                }
            }else{
                if kSharedUserDefaults.getLoggedInAccessToken() == ""{
                    self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Language".localized()]
                    self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","2135789_earth_language_planet_icon"]
                }else{
                    self.menuArr = ["Real Estate".localized(),"Members".localized(),"Request".localized(),"Who are we".localized(),"Call Us".localized(),"Other Services".localized(),"Carrers".localized(),"Profile".localized(),"Settings".localized(),"Language".localized()]
                    self.imageArr = ["property","members","Requests","who are we","Call","Other Services","career","Profile","Setting","2135789_earth_language_planet_icon"]
                }
            }
            self.mainTableView.reloadData()
        }
        if checkVal == 9{
            if indexPath.row == 7{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "ProfileVC", storyboard: storyboard)
            }
            else if indexPath.row == 8{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "SettingsVC", storyboard: storyboard)
            }
            else if indexPath.row == 10{
                kSharedUserDefaults.setLanguage(languageName: "en")
                kSharedAppDelegate?.setSemanticContentAttribute()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "KYDrawerController", storyboard: storyboard)
            }else if indexPath.row == 11{
                kSharedUserDefaults.setLanguage(languageName: "ar")
                kSharedAppDelegate?.setSemanticContentAttribute()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                pushToVC(identifierName: "KYDrawerController", storyboard: storyboard)
            }
        }else{
             if indexPath.row == 8{
               kSharedUserDefaults.setLanguage(languageName: "en")
               kSharedAppDelegate?.setSemanticContentAttribute()
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               pushToVC(identifierName: "KYDrawerController", storyboard: storyboard)
            }else if indexPath.row == 9{
                kSharedUserDefaults.setLanguage(languageName: "ar")
                              kSharedAppDelegate?.setSemanticContentAttribute()
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              pushToVC(identifierName: "KYDrawerController", storyboard: storyboard)
            }
        }
        
    }
}
