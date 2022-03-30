//
//  SearchMapVC.swift
//  Akariyoun
//
//  Created by vidur on 30/03/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import MapKit

class SearchMapVC: UIViewController {

    
    @IBOutlet weak var appleMapView: MKMapView!
    var locationManager = CLLocationManager()
    
    var isFirstOverlayAdded = false
    
    var kmlVal : KMLDocument?
    
    var docArr = [KMLDocument]()
    
    var overlayArr = [MKOverlay]()
    
    static var colorsArr = [UIColor]()
    
    //  @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UITapGestureRecognizer(target: self, action: #selector(self.handleLongPress(gestureReconizer:)))
        self.appleMapView.addGestureRecognizer(lpgr)
        self.appleMapView.delegate = self
        
    
        self.appleMapView.showsPointsOfInterest = false
     self.appleMapView.mapType = .mutedStandard
        
        // 23.8859 saudi latitude
        //45.0792 saudi longitude
        
        self.setStatusBarColor()
        for _ in 0..<187{
            let color = UIColor.random().withAlphaComponent(0.4)
            SearchMapVC.self.colorsArr.append(color)
        }
        
        self.animateCamera(coord: CLLocationCoordinate2D.init(latitude: 24.7136, longitude: 46.6753))
        
        //   self.loadKml("riyadh", isFirst: true)
        
        
        self.loadKml("2nd Industrial City", isFirst: true)
        self.loadKml("Al Amal Dist", isFirst: true)
        self.loadKml("Al Ammajiyah Dist", isFirst: true)
        self.loadKml("Al Andalus Dist", isFirst: true)
        self.loadKml("Al Aqeeq Dist", isFirst: true)
        self.loadKml("Al Arid Dist", isFirst: true)
        self.loadKml("Al Awaly Dist", isFirst: true)
        self.loadKml("Al Aziziyah Dist", isFirst: true)
        self.loadKml("Al Badiah Dist", isFirst: true)
        self.loadKml("Al Bariyah Dist", isFirst: true)
        self.loadKml("Al Basatin Dist", isFirst: true)
        self.loadKml("Al Bayan Dist", isFirst: true)
        self.loadKml("Al Butaiha Dist", isFirst: true)
        self.loadKml("Al Dahou Dist", isFirst: true)
        self.loadKml("Al Danah Dist", isFirst: true)
        self.loadKml("Al Dar Al Baida Dist", isFirst: true)
        self.loadKml("Al Dhubbat Dist", isFirst: true)
        self.loadKml("Al Difaa Dist", isFirst: true)
        self.loadKml("Al Dirah Dist", isFirst: true)
        self.loadKml("Al Dubiyah Dist", isFirst: true)
        self.loadKml("Al Duraihemiyah Dist", isFirst: true)
        self.loadKml("Al Ezdihar Dist", isFirst: true)
        self.loadKml("Al Faisaliyah Dist", isFirst: true)
        self.loadKml("Al Fakhiriyah Dist", isFirst: true)
        self.loadKml("Al Falah Dist", isFirst: true)
        self.loadKml("Al Farooq Dist", isFirst: true)
        self.loadKml("Al Fayha Dist", isFirst: true)
        self.loadKml("Al Fursan Dist", isFirst: true)
        self.loadKml("Al Ghadeer Dist", isFirst: true)
        self.loadKml("Al Ghannamiyah Dist", isFirst: true)
        self.loadKml("Al Hada Dist", isFirst: true)
        self.loadKml("Al Haer Dist", isFirst: true)
        self.loadKml("Al Hamra Dist", isFirst: true)
        self.loadKml("Al Hazm Dist", isFirst: true)
        self.loadKml("Al Iskan Dist", isFirst: true)
        self.loadKml("Al Janadriyah Dist", isFirst: true)
        self.loadKml("Al Jarradiyah Dist", isFirst: true)
        self.loadKml("Al Jazeerah Dist", isFirst: true)
        self.loadKml("Al Khair Dist", isFirst: true)
        self.loadKml("Al Khaleej Dist", isFirst: true)
        self.loadKml("Al Khalidiyah Dist", isFirst: true)
        self.loadKml("Al Khuzama Dist", isFirst: true)
        self.loadKml("Al Mahdiyah Dist", isFirst: true)
        self.loadKml("Al Maizalah Dist", isFirst: true)
        self.loadKml("Al Majd Dist", isFirst: true)
        self.loadKml("Al Malaz Dist", isFirst: true)
        self.loadKml("Al Malqa Dist", isFirst: true)
        self.loadKml("Al Manakh Dist", isFirst: true)
        self.loadKml("Al Manar Dist", isFirst: true)
        self.loadKml("Al Mansurah Dist", isFirst: true)
        self.loadKml("Al Marjan Dist", isFirst: true)
        self.loadKml("Al Marqab Dist", isFirst: true)
        self.loadKml("Al Marwah Dist", isFirst: true)
        self.loadKml("Al Masani Dist", isFirst: true)
        self.loadKml("Al Maseef Dist", isFirst: true)
        self.loadKml("Al Mashriq Dist", isFirst: true)
        self.loadKml("Al Mathar Dist", isFirst: true)
        self.loadKml("Al Misfat Dist", isFirst: true)
        self.loadKml("Al Mishael Dist", isFirst: true)
        self.loadKml("Al Mughrazat Dist", isFirst: true)
        self.loadKml("Al Muhammadiyah Dist", isFirst: true)
        self.loadKml("Al Munisiyah Dist", isFirst: true)
        self.loadKml("Al Murabba Dist", isFirst: true)
        self.loadKml("Al Mursalat Dist", isFirst: true)
        self.loadKml("Al Muruj Dist", isFirst: true)
        self.loadKml("Al Mutamarat Dist", isFirst: true)
        self.loadKml("Al Nada Dist", isFirst: true)
        self.loadKml("Al Nadheem Dist", isFirst: true)
        self.loadKml("Al Nadwah Dist", isFirst: true)
        self.loadKml("Al Nafel Dist", isFirst: true)
        self.loadKml("Al Nahdah Dist", isFirst: true)
        self.loadKml("Al Nakhbah Dist", isFirst: true)
        self.loadKml("Al Nakheel Dist", isFirst: true)
        self.loadKml("Al Namudhajiyah Dist", isFirst: true)
        self.loadKml("Al Narjis Dist", isFirst: true)
        self.loadKml("Al Nasiriyah Dist", isFirst: true)
        self.loadKml("Al Noor Dist", isFirst: true)
        self.loadKml("Al Nuzha Dist", isFirst: true)
        self.loadKml("Al Olaya Dist", isFirst: true)
        self.loadKml("Al Oud Dist", isFirst: true)
        self.loadKml("Al Qadisiyah Dist", isFirst: true)
        self.loadKml("Al Qairawan Dist", isFirst: true)
        self.loadKml("Al Quds Dist", isFirst: true)
        self.loadKml("Al Qura Dist", isFirst: true)
        self.loadKml("Al Rabiyah Dist", isFirst: true)
        self.loadKml("Al Raed Dist", isFirst: true)
        self.loadKml("Al Rawabi Dist", isFirst: true)
        self.loadKml("Al Rawdah Dist", isFirst: true)
        self.loadKml("Al Rayah Dist", isFirst: true)
        self.loadKml("Al Rayan Dist", isFirst: true)
        self.loadKml("Al Rehab Dist", isFirst: true)
        self.loadKml("Al Rimal Dist", isFirst: true)
        self.loadKml("Al Rimayah Dist", isFirst: true)
        self.loadKml("Al Risalah Dist", isFirst: true)
        self.loadKml("Al Saadah Dist", isFirst: true)
        self.loadKml("Al Safa Dist", isFirst: true)
        self.loadKml("Al Sahab Dist", isFirst: true)
        self.loadKml("Al Sahafah Dist", isFirst: true)
        self.loadKml("Al Salam Dist", isFirst: true)
        self.loadKml("Al Sharafiyah Dist", isFirst: true)
        self.loadKml("Al Shifa Dist", isFirst: true)
        self.loadKml("Al Shohda Dist", isFirst: true)
        self.loadKml("Al Sholah Dist", isFirst: true)
        self.loadKml("Al Shumaisi Dist", isFirst: true)
        self.loadKml("Al Sidrah Dist", isFirst: true)
        self.loadKml("Al Sinaiyah Dist", isFirst: true)
        self.loadKml("Al Sulaimaniyah Dist", isFirst: true)
        self.loadKml("Al Sulay Dist", isFirst: true)
        self.loadKml("Al Suwaidi Dist", isFirst: true)
        self.loadKml("Al Taawun Dist", isFirst: true)
        self.loadKml("Al Tadamun Dist", isFirst: true)
        self.loadKml("Al Ula Dist", isFirst: true)
        self.loadKml("Al Uraija Dist", isFirst: true)
        self.loadKml("Al Wadi Dist", isFirst: true)
        self.loadKml("Al Wahah Dist", isFirst: true)
        self.loadKml("Al Wasam Dist", isFirst: true)
        self.loadKml("Al Wisham Dist", isFirst: true)
        self.loadKml("Al Wizarat Dist", isFirst: true)
        self.loadKml("Al Woroud Dist", isFirst: true)
        self.loadKml("Al Wusayta Dist", isFirst: true)
        self.loadKml("Al Yamamah Dist", isFirst: true)
        self.loadKml("Al Yarmuk Dist", isFirst: true)
        self.loadKml("Al Yasmeen Dist", isFirst: true)
        self.loadKml("Al Zaher Dist", isFirst: true)
        self.loadKml("Al Zahour Dist", isFirst: true)
        self.loadKml("Al Zahra Dist", isFirst: true)
        self.loadKml("Al Zahrah Dist", isFirst: true)
        self.loadKml("Ar Rabie Dist", isFirst: true)
        self.loadKml("Ar Rabwah Dist", isFirst: true)
        self.loadKml("Ar Rafiah Dist", isFirst: true)
        self.loadKml("Ar Rahmaniyah Dist", isFirst: true)
        self.loadKml("As Salhiyah Dist", isFirst: true)
        self.loadKml("Assafarat Dist", isFirst: true)
        self.loadKml("Badr Dist", isFirst: true)
        self.loadKml("Banban Dist", isFirst: true)
        self.loadKml("Dahiyat Namar Dist", isFirst: true)
        self.loadKml("Dhahrat Al Badeah Dist", isFirst: true)
        self.loadKml("Dhahrat Laban Dist", isFirst: true)
        self.loadKml("Dirab Dist", isFirst: true)
        self.loadKml("East Naseem Dist", isFirst: true)
        self.loadKml("East Umm Al Hamam Dist", isFirst: true)
        self.loadKml("Ghirnatah Dist", isFirst: true)
        self.loadKml("Ghobairah Dist", isFirst: true)
        self.loadKml("Hiteen Dist", isFirst: true)
        self.loadKml("Hyt Dist", isFirst: true)
        self.loadKml("Imam Muhammed Bin Saud Islamic University", isFirst: true)
        self.loadKml("Ishbiliyah Dist", isFirst: true)
        self.loadKml("Jabrah Dist", isFirst: true)
        self.loadKml("Jareer Dist", isFirst: true)
        self.loadKml("Khashm Al An", isFirst: true)
        self.loadKml("King Abdulaziz Dist", isFirst: true)
        self.loadKml("King Abdullah City For Energy", isFirst: true)
        self.loadKml("King Abdullah Dist", isFirst: true)
        self.loadKml("King Fahd Dist", isFirst: true)
        self.loadKml("King Faisal Dist", isFirst: true)
        self.loadKml("King Khalid International Airport", isFirst: true)
        self.loadKml("King Saud University", isFirst: true)
        self.loadKml("Laban Dist", isFirst: true)
        self.loadKml("Manfuha Al Jadidah Dist", isFirst: true)
        self.loadKml("Manfuhah Dist", isFirst: true)
        self.loadKml("Mansuriyah Dist", isFirst: true)
        self.loadKml("Meakal Dist", isFirst: true)
        self.loadKml("Middle Oraija Dist", isFirst: true)
        self.loadKml("Namar Dist", isFirst: true)
        self.loadKml("North Mathar Dist", isFirst: true)
        self.loadKml("Ohod Dist", isFirst: true)
        self.loadKml("Okaz Dist", isFirst: true)
        self.loadKml("Olaishah Dist", isFirst: true)
        self.loadKml("Oraid Dist", isFirst: true)
        self.loadKml("Qurtubah Dist", isFirst: true)
        self.loadKml("Salahuddin Dist", isFirst: true)
        self.loadKml("Salam Park", isFirst: true)
        self.loadKml("Shubra Dist", isFirst: true)
        self.loadKml("Siyah Dist", isFirst: true)
        self.loadKml("Skirinah Dist", isFirst: true)
        self.loadKml("Sultanah Dist", isFirst: true)
        self.loadKml("Taybah Dist", isFirst: true)
        self.loadKml("Thulaim Dist", isFirst: true)
        self.loadKml("Tuwaiq Dist", isFirst: true)
        self.loadKml("Umm Al Shaal Dist", isFirst: true)
        self.loadKml("Umm Saleem Dist", isFirst: true)
        self.loadKml("Utayqah Dist", isFirst: true)
        self.loadKml("Wady Laban Dist", isFirst: true)
        self.loadKml("West Naseem Dist", isFirst: true)
        self.loadKml("West Oraija Dist", isFirst: true)
        self.loadKml("West Suwaidi Dist", isFirst: true)
        self.loadKml("West Umm Al Hamam Dist", isFirst: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func animateCamera(coord : CLLocationCoordinate2D) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
            
            self.appleMapView.setCenter(coord, animated: true)
            
            
            let location = coord
            let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(exactly: 60000)!, longitudinalMeters: CLLocationDistance(exactly: 60000)!)
            self.appleMapView.setRegion(self.appleMapView.regionThatFits(region), animated: true)
        }
    }
    
    
    
    @objc func handleLongPress(gestureReconizer: UITapGestureRecognizer) {
        
        let touchLocation = gestureReconizer.location(in: self.appleMapView)
        let locationCoordinate = self.appleMapView.convert(touchLocation,toCoordinateFrom: self.appleMapView)
        
        let location = CLLocation.init(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        
        let point = MKMapPoint(locationCoordinate)
        
        
        for overlay in 0..<(self.overlayArr.count ){
            
            let cir = (self.overlayArr[overlay])
            
            if (cir is MKPolygon) {
                //    let circle = overlay
                let circleRenderer = (self.appleMapView.renderer(for: cir) as? MKPolygonRenderer)
                let datapoint = circleRenderer?.point(for: point)
            
                circleRenderer?.invalidatePath()
                
                
                if circleRenderer?.path.contains(datapoint ?? CGPoint()) ?? false {
                    
                    circleRenderer?.fillColor = UIColor.black.withAlphaComponent(0.4)
                    circleRenderer?.lineWidth = 1
                    circleRenderer?.strokeColor = UIColor.black
                  //  self.addAnnotations(coords: [location], title: self.docArr[overlay].name, subTitle: self.docArr[overlay].arName)
                    
                    
                }else{
                    circleRenderer?.fillColor = SearchMapVC.self.colorsArr[overlay]
                    circleRenderer?.lineWidth = 1
                    circleRenderer?.strokeColor = UIColor.black
                }
            }
        }
    }
    
    
//    func addAnnotations(coords: [CLLocation],title : String,subTitle : String){
//        for coord in coords{
//            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
//                                                      longitude: coord.coordinate.longitude);
//            let anno = MKPointAnnotation();
//            anno.coordinate = CLLCoordType;
//            anno.title = title
//            anno.subtitle = subTitle
//            self.appleMapView.addAnnotation(anno);
//        }
//    }
    
    
    
    fileprivate func loadKml(_ path: String,isFirst : Bool) {
        let url = Bundle.main.url(forResource: path, withExtension: "kml")
        KMLDocument.parse(url: url!, isFirst: isFirst, callback:
            { [unowned self] (kml) in
                // Add overlays
                
                
                
                
                
                //   self.kmlVal?.overlays.append(contentsOf: kml.overlays)
                
                //  self.appleMapView.addOverlays(kml.overlays)
                
                self.docArr.append(kml)
                self.overlayArr.append(contentsOf: kml.overlays)
                
                
                if path == "Oraid Dist"{
                    for overlay in 0..<(self.overlayArr.count ){
                        
                        let cir = (self.overlayArr[overlay])
                        
                        if (cir is MKPolygon) {
                            //    let circle = overlay
                            let circleRenderer = (self.appleMapView.renderer(for: cir) as? MKPolygonRenderer)
                         //   let datapoint = circleRenderer?.point(for: point)
                            
                            circleRenderer?.invalidatePath()
                                circleRenderer?.fillColor = SearchMapVC.self.colorsArr[overlay]
                                circleRenderer?.lineWidth = 1
                                circleRenderer?.strokeColor = UIColor.black
                        }
                    }
                    
                    self.appleMapView.addOverlays(self.overlayArr)
                    self.appleMapView.layoutIfNeeded()
                                   self.appleMapView.setNeedsLayout()
                                   // Add annotations
                                   self.appleMapView.showAnnotations(kml.annotations, animated: true)
                }
                
                //                    if isFirst{
                //
                //                        self.isFirstOverlayAdded = false
                //                    }else{
                //                        if self.isFirstOverlayAdded{
                //                            var arr = [MKOverlay]()
                //                        for i in  816..<self.appleMapView.overlays.count{
                //                            print(i,"CHECK I VIDUR")
                //                            arr.append(self.appleMapView.overlays[i])
                //                                 //  self.appleMapView.removeOverlay(self.appleMapView.overlays[i])
                //                               }
                //                            self.appleMapView.removeOverlays(arr)
                //                        }
                //                        self.appleMapView.addOverlays(kml.overlays)
                //
                //                        self.isFirstOverlayAdded = true
                //
                ////                        print(self.appleMapView.overlays.count,"CHECK All OVERLAY COUNT VIDUR")
                ////                        print(kml.overlays.count,"CHECK OVERLAY COUNT VIDUR")
                //                    }
               
            }
        )
    }
}

extension SearchMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlayPolyline = overlay as? KMLOverlayPolyline {
            // return MKPolylineRenderer
            return overlayPolyline.renderer()
        }
        if let overlayPolygon = overlay as? KMLOverlayPolygon {
            // return MKPolygonRenderer
            return overlayPolygon.renderer()
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))

            pinView.image = UIImage.init(named: "newark_nj_1922")
            let rightButton = UIButton(type: .contactAdd)
            rightButton.tag = annotation.hash

            pinView.animatesDrop = true
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton

            return pinView
        }
        else {
            return nil
        }
    }

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
}