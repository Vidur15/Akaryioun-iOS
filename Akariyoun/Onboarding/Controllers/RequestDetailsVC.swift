//
//  RequestDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class RequestDetailsVC: UIViewController {

    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var requestDescLbl: UILabel!
    @IBOutlet weak var requestTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    var obj : RequestMainDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarColor()
        self.cardView.drawShadowwithCorner()
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.screenEdgePanGestureEnabled = false
        }
        
        self.setData()
        
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        self.nameLbl.text = "\(self.obj?.user?.first_name ?? "") \(self.obj?.user?.last_name ?? "")"
        self.mainImgView.downlodeImage(serviceurl: self.obj?.user?.profile_pic ?? "", placeHolder: UIImage.init(named: "2024644_login_user_avatar_person_users_icon"))
        self.dateLbl.text = "Posted on :".localized() + "\(self.obj?.created_at ?? "")"
        self.requestTitleLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.obj?.title ?? "" : self.obj?.title_ar ?? ""
        self.requestDescLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.obj?.description ?? "" : self.obj?.description_ar ?? ""
        self.contactLbl.text = self.obj?.user?.mobile_number ?? ""
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
