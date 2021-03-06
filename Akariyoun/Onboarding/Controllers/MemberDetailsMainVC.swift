//
//  MemberDetailsMainVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController

class MemberDetailsMainVC: UIViewController {

    @IBOutlet weak var backBtnOut: UIButton!
    @IBOutlet var containerViewColl: [UIView]!
    
    @IBOutlet var btnSelectOutColl: [UIButton]!
    
    @IBOutlet weak var animateView: UIView!
    
    var idToSend = ""
    
    var whoVC : WhoWeAreVC!
    var realEstateVC : MemberCallUsVC!
    var requestVC : MemberRequestsVC!
    var offerVC : MemberOffersVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        if let drawerController = navigationController?.parent as? KYDrawerController {
                                 drawerController.screenEdgePanGestureEnabled = false
                             }
        self.backBtnOut.setImage(kSharedUserDefaults.getLanguageName() == "en" ? UIImage.init(named: "arrow-back") : UIImage.init(named: "Back arrow"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func transformView(sender:UIView) {
           UIView.animate(withDuration: 0.5) {
               print(sender.frame.origin.x,"X POSITION")
              self.animateView.transform = kSharedUserDefaults.getLanguageName() == "en" ?  CGAffineTransform(translationX: sender.frame.origin.x, y: 0) : CGAffineTransform(translationX: -(sender.frame.origin.x), y: 0)
           }
       }
    
    @IBAction func selectionAction(_ sender: UIButton) {
        for i in 0..<self.containerViewColl.count{
            if i == sender.tag{
                self.containerViewColl[i].alpha = 1
            }else{
                self.containerViewColl[i].alpha = 0
            }
        }
        if kSharedUserDefaults.getLanguageName() == "en"{
            self.transformView(sender: sender)
        }else{
            print(sender.tag)
            let abc = (self.btnSelectOutColl.count - 1)
            print(abc - sender.tag,"checggg")
            self.transformView(sender: self.btnSelectOutColl[abc - sender.tag])
        }
  //  self.transformView(sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "who"{
        self.whoVC = (segue.destination as? WhoWeAreVC)
        self.whoVC.sender = self
    }
    else if segue.identifier == "real"{
        self.realEstateVC = (segue.destination as? MemberCallUsVC)
        self.realEstateVC.sender = self
    }
    else if segue.identifier == "request"{
        self.requestVC = (segue.destination as? MemberRequestsVC)
        self.requestVC.sender = self
    }else if segue.identifier == "offer"{
        self.offerVC = (segue.destination as? MemberOffersVC)
        self.offerVC.sender = self
    }
    }
}
