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
    
    var scrollImg: UIScrollView = UIScrollView()
    
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
        
        
      
        self.propertyDetailsMainImgView.downloadedsvg(from: svg){ [weak self] value in
            var vWidth = self?.propertyDetailsMainImgView.frame.size.width ?? 0
            var vHeight = self?.propertyDetailsMainImgView.frame.size.height ?? 0
            print(self?.propertyDetailsMainImgView.image?.size.height ?? 0,"CHECH HEIGHT")
            print(self?.propertyDetailsMainImgView.image?.size.width ?? 0,"CHECH WIDth")
               
            self?.scrollImg.delegate = self
           
            self?.scrollImg.frame = CGRect.init(x: self?.mainImageScrollView.frame.origin.x ?? 0
                                                , y: self?.mainImageScrollView.frame.origin.y ?? 0, width: vWidth, height: vHeight)
                
            
            self?.scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
            self?.scrollImg.alwaysBounceVertical = false
            self?.scrollImg.alwaysBounceHorizontal = false
            self?.scrollImg.showsVerticalScrollIndicator = true
            self?.scrollImg.flashScrollIndicators()

     //   self?.scrollImg.translatesAutoresizingMaskIntoConstraints = true
    //        self.propertyDetailsMainImgView.translatesAutoresizingMaskIntoConstraints = false
            
            self?.scrollImg.minimumZoomScale = 0.0
            self?.scrollImg.maximumZoomScale = 10.0
            
            self?.scrollImg.isScrollEnabled = true

            self?.scrollImg.pinchGestureRecognizer?.isEnabled = true
          //  scrollImg.setZoomScale(2.0, animated: true)
            
            self?.mainImageScrollView.isUserInteractionEnabled = false
            
          //  propertyDetailsMainImgView!.layer.cornerRadius = 11.0
            self?.propertyDetailsMainImgView!.clipsToBounds = true
            self?.propertyDetailsMainImgView.isUserInteractionEnabled = true
            self?.scrollImg.addSubview((self?.propertyDetailsMainImgView!)!)
            self?.mainScrollView.addSubview(self?.scrollImg ?? UIScrollView())
            
           self?.scrollImg.contentSize = (self?.propertyDetailsMainImgView.image?.size)!
            self?.propertyDetailsMainImgView.layoutIfNeeded()
            self?.scrollImg.layoutIfNeeded()
            self?.propertyDetailsMainImgView.isUserInteractionEnabled = true
            print(self?.scrollImg.contentSize,"CHECK SCROLL BEFORE")
        }
        
        
        
        
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
        
        for i in self.propertyModel?.data?.imagemap ?? []{
            let lbl = UILabel.init(frame: CGRect.init(x: Double.getDouble(i.x1), y: Double.getDouble(i.y1), width: Double.getDouble(i.w), height: Double.getDouble(i.h)))
            lbl.text = i.land_num ?? ""
            self.propertyDetailsMainImgView.addSubview(lbl)
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            
            
            
       //     lbl.backgroundColor = .green
        }
        
        
        var newx : Double = 0.0
        var newy : Double = 0.0
        var newWidth : Double = 0.0
        var rotate = ""
        var webkit = false
        
        for i in self.propertyModel?.data?.street_data ?? []{
   //     let width = i.st_name_en?.widthOfString(usingFont: UIFont.init(name: UIFont.systemFont(ofSize: 16))
      //      let width = i.st_name_en?.widthOfString(usingFont: UIFont.systemFont(ofSize: 16))
            if i.style_attr_mobille?.count > 1{
             //   print(i.style_attr_mobille,"CHECK DATA VIDUR")
               
                
                for j in 0..<(i.style_attr_mobille?.count ?? 0){
                    
                    switch i.style_attr_mobille?[j] {
                    case "width":
                        let width = i.style_attr_mobille?[j + 1]
                       let acb = width?.dropLast(2)
                          let bcd = acb?.replacingOccurrences(of: " ", with: "")
                         newWidth = Double.getDouble(bcd)
                    case " left":
                        let x = i.style_attr_mobille?[j + 1]
                       let acb1 = x?.dropLast(2)
                          let bcd1 = acb1?.replacingOccurrences(of: " ", with: "")
                         newx = Double.getDouble(bcd1)
                    case " top":
                        let y = i.style_attr_mobille?[j + 1]
                       let acb2 = y?.dropLast(2)
                          let bcd2 = acb2?.replacingOccurrences(of: " ", with: "")
                         newy = Double.getDouble(bcd2)
                    case " transform":
                        rotate = i.style_attr_mobille?[j + 1] ?? ""
                        webkit = false
                    case " -webkit-transform":
                        rotate = i.style_attr_mobille?[j + 1] ?? ""
                        webkit = true
                        
                    default:
                        print("default")
                    }
            }
                
                let lbl1 = UILabel.init(frame: CGRect.init(x: newx, y: newy, width: newWidth, height: 45))
               
                lbl1.text = (i.st_name_en ?? "").capitalized
                
                self.propertyDetailsMainImgView.addSubview(lbl1)
                lbl1.textColor = .black
            lbl1.textAlignment = .center
                lbl1.numberOfLines = 0
                lbl1.sizeToFit()
                lbl1.layoutIfNeeded()
                lbl1.transform = CGAffineTransform.init(rotationAngle: 0)
                lbl1.font = UIFont.systemFont(ofSize: 14)
                
              //  lbl1.transform = CGAffineTransform(a: 0, b: tan(0), c: 0.0, d: 0.0, tx: 0.0, ty: 0.0)
                
                if rotate == " rotate(0deg)"{
                    lbl1.transform = CGAffineTransform.init(rotationAngle: 0)
                }else if rotate == " rotate(-90deg)"{
                    if webkit == false{
                      //  lbl1.backgroundColor = .red
                        lbl1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2).concatenating(CGAffineTransform(translationX: -50, y: -100))
                    }else{
                        print("here inside webkit")
                     //   lbl1.backgroundColor = .green
                        lbl1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2).concatenating(CGAffineTransform(translationX: -75, y: -100))
                    }
                    
                   // lbl1.transform = CGAffineTransform.init(translationX: -16, y: -16)
                }
                
                
            }
}
        
        //
        
        //
        
        
        //
        
        
//        var str = self.propertyModel?.data?.street_data?[0].style_attr?.replacingOccurrences(of: ";", with: ",")
//        print(str,"STR")
//       var check = str?.replacingOccurrences(of: ",", with: "")
//        print(check,"check")
//       var test = check?.replacingOccurrences(of:"\"", with: "")
//        print(test,"test")
//        let arr = test?.components(separatedBy: ":")
//
//       var strArr = [String]()
//
//        for i in arr ?? []{
//            strArr.append(String.getString(i))
//        }
//
//        print(strArr,"StrArr")
//
//      //  str = ("[" + (str ?? ""))
//        str?.removeLast()
//      //  str! += "]"
//
//           // ("{" +  + "}")
//        let convertedSTR =  self.convertToDictionary(text: str ?? "")

  //      let dummySTR = ["width": "292.8140000000003px", "top": "2738.805419921875px", "left": "2435.749267578125px", "-webkit-transform-origin": "0% 0%", "-webkit-transform": "rotate(0deg)", "font-size": "14px"]
        
        
      //  print(str ?? "","STR")
        
        
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
        print(scrollImg.contentSize,"CHECK SCROLL AFTER")
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
extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
