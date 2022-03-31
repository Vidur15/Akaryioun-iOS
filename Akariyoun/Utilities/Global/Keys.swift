

import Foundation

/** UserDefaults */
struct UserDefaultsKey {
    static let isLoadedBefore                   = "isLoadedBefore"
    static let userId                           = "id"
    static let accessToken                      = "access_token"
    static let loggedInUserDetails              = "loggedInUserDetails"
    static let isUserLoggedIn                   = "isUserLoggedIn"
    static let device_type                      = "deviceType"
    static let device_token                     = "deviceToken"
    
}

//** Device*/
//struct Device {
//    static let deviceToken                          = sharedUserDefaults.getDeviceToken() == "" ? "1234" : sharedUserDefaults.getDeviceToken()
//    static let deviceType                           = "1"
//    static let latitude                             = Double.getDouble(sharedAppDelegate.locationDic["latitude"])
//    
//    static let longitude                            = Double.getDouble(sharedAppDelegate.locationDic["longitude"])
//}

//MARK:- API Keys
struct APIKeys {
    
}

enum AppStoryBoard : String {
    case registration = "Registration"
    case home         = "Home"
}
