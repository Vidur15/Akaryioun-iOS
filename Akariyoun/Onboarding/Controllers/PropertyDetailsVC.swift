//
//  PropertyDetailsVC.swift
//  Akariyoun
//
//  Created by vidur on 25/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import KYDrawerController
import SVGKit
import WebKit
import ISVImageScrollView

class PropertyDetailsVC: UIViewController,UIScrollViewDelegate{

@IBOutlet weak var mainImageScrollView: ISVImageScrollView!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var propertyDetailsMainImgView: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var earthViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    
    
    @IBOutlet weak var secondMobileLbl: UILabel!
    @IBOutlet weak var westLengthLbl: UILabel!
    @IBOutlet weak var eastLengthLbl: UILabel!
    @IBOutlet weak var southLengthLbl: UILabel!
    @IBOutlet weak var northLengthLb: UILabel!
    @IBOutlet weak var westBorderLbl: UILabel!
    @IBOutlet weak var eastBorderLbl: UILabel!
    
    @IBOutlet weak var southBorderLbl: UILabel!
    @IBOutlet weak var northBorderLbl: UILabel!
    @IBOutlet weak var numPlannedLbl: UILabel!
    @IBOutlet weak var blockNumberLbl: UILabel!
    @IBOutlet weak var postNumberLbl: UILabel!
    
    
    @IBOutlet weak var authorImgView: UIImageView!
    @IBOutlet weak var authorNumberLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var topHeadingLbl: UILabel!
    
    @IBOutlet weak var lengthLimitView: UIView!
    @IBOutlet weak var earthView: UIView!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var userView: UIView!
    
    var idToSend = 0
    
    var propertyModel : PropertyDetailsModel?
    
  //  private var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
                   drawerController.screenEdgePanGestureEnabled = false
               }
        self.setStatusBarColor()
       self.userView.drawShadowwithCorner()
        self.PriceView.drawShadowwithCorner()
        self.earthView.drawShadowwithCorner()
        self.lengthLimitView.drawShadowwithCorner()
        
        self.mainCollectionView.delegate = self
                                self.mainCollectionView.dataSource = self
                                self.mainCollectionView.register(UINib(nibName: "PropertyImagesCVC", bundle: .main), forCellWithReuseIdentifier: "PropertyImagesCVC")
        
        self.mainTableView.delegate = self
               self.mainTableView.dataSource = self
               let nib = UINib(nibName: "EarthInfoTVC", bundle: Bundle.main)
               self.mainTableView.register(nib, forCellReuseIdentifier: "EarthInfoTVC")
                         
        self.getPropertyDetails()
        // Do any additional setup after loading the view.
    }
    
    
    func getPropertyDetails(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: ServiceName.propertyDetails + "?id=\(self.idToSend)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                
                //guard self != nil else { return }
                CommonUtils.showHudWithNoInteraction(show: false)
                if errorType == .requestSuccess {
                    let dicResponse = kSharedInstance.getDictionary(result)
                    let statusCodes = Int.getInt(statusCode)
                    switch statusCodes {
                    case 200:
                        if dicResponse["success"] as? Bool ?? false{
//                            let dataDict = kSharedInstance.getDictionary(dicResponse["data"])
//                            let propModel = kSharedInstance.getDictionary(dataDict["property"])
                            self.propertyModel = PropertyDetailsModel.init(dictionary: dicResponse as NSDictionary)
                            self.setData()
                            self.mainCollectionView.reloadData()
//                         print(self.propertyModel?.data?.property?.data?.count,"COUNT")
//                            self.mainTableView.reloadData()
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
    
    
    func setData(){
        self.topHeadingLbl.text = kSharedUserDefaults.getLanguageName() == "en" ? self.propertyModel?.data?.property?.title ?? "" : self.propertyModel?.data?.property?.title_ar ?? ""
        self.authorNameLbl.text = "\(self.propertyModel?.data?.property?.member?.first_name ?? "") \(self.propertyModel?.data?.property?.member?.last_name ?? "")"
        self.authorNumberLbl.text = self.propertyModel?.data?.property?.member?.mobile_number ?? ""
        self.authorImgView.downlodeImage(serviceurl: self.propertyModel?.data?.property?.member?.profile_pic ?? "", placeHolder: UIImage.init(named: "Logo"))
        self.secondMobileLbl.text = "Call".localized() + " : \(self.propertyModel?.data?.property?.member?.mobile_number ?? "")"
        
        self.northBorderLbl.text = self.propertyModel?.data?.property?.land_north ?? ""
        self.southBorderLbl.text = self.propertyModel?.data?.property?.land_south ?? ""
        self.eastBorderLbl.text = self.propertyModel?.data?.property?.land_east ?? ""
        self.westBorderLbl.text = self.propertyModel?.data?.property?.land_west ?? ""
        
        self.northLengthLb.text = self.propertyModel?.data?.property?.land_m_north ?? ""
        self.southLengthLbl.text = self.propertyModel?.data?.property?.land_m_south ?? ""
        self.eastLengthLbl.text = self.propertyModel?.data?.property?.land_m_east ?? ""
        self.westLengthLbl.text = self.propertyModel?.data?.property?.land_m_west ?? ""
        
        
     //   self.mainWebView.scrollView.delegate = self
        self.propertyDetailsMainImgView.isHidden = false
        let svg = URL(string: self.propertyModel?.data?.svg_url ?? "")!

     //   var request: NSURLRequest = NSURLRequest(url: svg)
   //     self.mainWebView.load(request as URLRequest)
     //   self.mainWebView.loadhtm
        
        
      //  let image = UIImage(named: "Photo.jpg")
     //   self.imageView = UIImageView(image: image)
        
//        self.mainImageScrollView.imageView = self.propertyDetailsMainImgView
////        self.mainImageScrollView.minimumZoomScale = 0.0
////        self.mainImageScrollView.maximumZoomScale = 2.0
// //       self.mainImageScrollView.setZoomScale(0, animated: true)
//        self.mainImageScrollView.delegate = self
      
//     //   self.mainImageScrollView.addSubview(self.propertyDetailsMainImgView)
        
        
        
        self.propertyDetailsMainImgView.downloadedsvg(from: svg)
        var vWidth = (self.view.frame.width - 40)
            var vHeight = 550

            var scrollImg: UIScrollView = UIScrollView()
            scrollImg.delegate = self
        scrollImg.frame = CGRect(x: self.mainImageScrollView.frame.origin.x
                                 , y: self.mainImageScrollView.frame.origin.y, width: vWidth, height: CGFloat(vHeight))
            scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
            scrollImg.alwaysBounceVertical = false
            scrollImg.alwaysBounceHorizontal = false
            scrollImg.showsVerticalScrollIndicator = true
            scrollImg.flashScrollIndicators()

//        scrollImg.translatesAutoresizingMaskIntoConstraints = false
//        self.propertyDetailsMainImgView.translatesAutoresizingMaskIntoConstraints = false
        
            scrollImg.minimumZoomScale = 0.0
        scrollImg.maximumZoomScale = 10.0
        
        scrollImg.isScrollEnabled = true

        scrollImg.pinchGestureRecognizer?.isEnabled = true
      //  scrollImg.setZoomScale(2.0, animated: true)
        self.mainScrollView.addSubview(scrollImg)

      //  propertyDetailsMainImgView!.layer.cornerRadius = 11.0
        propertyDetailsMainImgView!.clipsToBounds = false
            scrollImg.addSubview(propertyDetailsMainImgView!)
        
        
        self.propertyDetailsMainImgView.layoutIfNeeded()
        scrollImg.layoutIfNeeded()
        
        
        self.propertyDetailsMainImgView.isUserInteractionEnabled = true
        if self.propertyModel?.data?.property?.property_land_info?.count == 0{
            self.earthViewHeightConst.constant = 0
            self.earthView.isHidden = true
        }else{
            self.earthView.isHidden = false
        UIView.animate(withDuration: 1.0) {
        
                   self.mainTableHeightConst.constant = CGFloat.greatestFiniteMagnitude
                   self.mainTableView.reloadData()
            self.mainTableView.reloadSections([0], with: .automatic)
                   self.mainTableView.layoutIfNeeded()
                   self.mainTableHeightConst.constant = self.mainTableView.contentSize.height
            self.earthViewHeightConst.constant = (self.mainTableHeightConst.constant + 48)
                   self.mainScrollView.layoutIfNeeded()
               }
        }
        
//        for i in self.propertyModel?.data?.imagemap ?? []{
//            let lbl = UILabel.init(frame: CGRect.init(x: Double.getDouble(i.x1), y: Double.getDouble(i.y1), width: Double.getDouble(i.w), height: Double.getDouble(i.h)))
//            lbl.text = i.land_num ?? ""
//            self.propertyDetailsMainImgView.addSubview(lbl)
//            lbl.textColor = .black
//            lbl.textAlignment = .center
//            lbl.numberOfLines = 0
//       //     lbl.backgroundColor = .green
//        }
        
        var str = self.propertyModel?.data?.street_data?[0].style_attr?.replacingOccurrences(of: ";", with: ",")
        print(str,"STR")
       var check = str?.replacingOccurrences(of: ",", with: "")
        print(check,"check")
       var test = check?.replacingOccurrences(of:"\"", with: "")
        print(test,"test")
        let arr = test?.components(separatedBy: ":")
        
       var strArr = [String]()
        
        for i in arr ?? []{
            strArr.append(String.getString(i))
        }
        
        print(strArr,"StrArr")
        
        str = ("{" + (str ?? ""))
        str?.removeLast()
        str! += "}"
        
           // ("{" +  + "}")
        let convertedSTR =  self.convertToDictionary(text: str ?? "")
        
        
        
        print(str ?? "","STR")
        print(convertedSTR,"CHECK THIS VIDUR")
        
    //    self.postNumberLbl.text = self.propertyModel?.property
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > scrollView.maximumZoomScale {
            scrollView.zoomScale = scrollView.maximumZoomScale
        } else if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return self.propertyDetailsMainImgView
    }
    
//    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
//       scrollView.pinchGestureRecognizer?.isEnabled = true
//    }
//
//    extension MyViewController: UIScrollViewDelegate {
//
//    }
    
    
    @IBAction func messageBtnAction(_ sender: UIButton) {
    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagePopVC" ) as? MessagePopVC  else { return }
       vc.modalPresentationStyle = .overFullScreen
       vc.modalTransitionStyle = .coverVertical
     //  vc.sender = self
       
       //  vc.meetUpModel = self.meetUpModel
       self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PropertyDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.propertyModel?.data?.property?.images?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyImagesCVC", for: indexPath) as! PropertyImagesCVC
        cell.mainImgView.downlodeImage(serviceurl: self.propertyModel?.data?.property?.images?[indexPath.item].name ?? "", placeHolder: UIImage.init(named: "Logo"))
        
    //    cell.mainIMageView.image = UIImage.init(named: "animation")
            
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height))
     
    }
}
extension PropertyDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyModel?.data?.property?.property_land_info?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "EarthInfoTVC", for: indexPath) as? EarthInfoTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.plannedNumberLbl.text = self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.sector_num ?? ""
        cell.blockNumberLbl.text = "\(self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.blockNum ?? 0)"
        cell.partNumberLbl.text = self.propertyModel?.data?.property?.property_land_info?[indexPath.row].image_map?.land_num ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}


//export function translateStyle(stringStyle) {
//  if (stringStyle && typeof stringStyle === "string") {
//    let newString = stringStyle;
//    newString = '{"' + newString;
//
//    if (newString.includes("-moz")) {
//      newString = newString + "}";
//      newString = newString.replaceAll(":", '":"');
//      newString = newString.replaceAll(";", '","');
//      newString = newString.replaceAll(',"}', "}");
//      newString = newString.replaceAll("-moz-transform", "MozTransform");
//      newString = newString.replaceAll(
//        "-moz-transform-origin",
//        "MozTransformOrigin"
//      );
//    } else {
//      newString = newString + '"}';
//      newString = newString.replaceAll(": ", '": "');
//      newString = newString.replaceAll("; ", '", "');
//    }
//    newString = newString.replaceAll(";", "");
//    newString = newString.replaceAll("font-size", "fontSize");
//    newString = newString.replaceAll("transform-origin", "transformOrigin");
//    newString = newString.replaceAll("-webkit-transform", "WebkitTransform");
//    newString = newString.replaceAll(
//      "-webkit-transform-origin",
//      "WebkitTransformOrigin"
//    );
//
//    return JSON.parse(newString);
//  }
//
//  return {};
//}
