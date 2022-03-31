

import Foundation
import CoreLocation
import Alamofire
class LocationManager:NSObject,CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var latitiude:Double = 0.0
    var longitude:Double = 0.0
    var cllocations:[CLLocation] = []
    var currentLocation = ""
    var locality = ""
    static var sharedInstance = LocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        cllocations = locations
        self.stopUpdatingLocation()
        self.latitiude = locations.first?.coordinate.latitude ?? 0.0
        self.longitude = locations.first?.coordinate.longitude ?? 0.0
        print("latitude \(latitiude),longitude \(longitude)")
        let userLocation :CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks as? [CLPlacemark]
            if placemark?.count>0{
                let placemark = placemarks![0]
                self.locality = placemark.locality ?? ""
                self.currentLocation = "\(placemark.subThoroughfare ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.administrativeArea ?? ""),  \(placemark.country ?? "")"
                print(self.currentLocation)
                //                  self.labelUserLocation.text = self.currentLocation
            }
        }
    }
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    func getLocation(latitude:Double,longitude:Double)->String{
        var location = ""
        let serverKey = "AIzaSyBT7SuUp2T8P42bPFnV8liz0ewib3laNFw"
        let serviceName = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(serverKey)"
        let googleStr = serviceName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //CommonUtils.showHud(show: true)
        Alamofire.request(googleStr ?? "", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
            //CommonUtils.showHud(show: false)
            let respon = kSharedInstance.getDictionary(response.result.value)
            guard let arr =  kSharedInstance.getArray(respon["results"]) as? [[String:Any]] else {return}
            let addressDict = kSharedInstance.getDictionaryArray(withDictionary: arr[0]["address_components"])
            location = String.getString(addressDict[4]["long_name"])
        }
         return location
    }
}
