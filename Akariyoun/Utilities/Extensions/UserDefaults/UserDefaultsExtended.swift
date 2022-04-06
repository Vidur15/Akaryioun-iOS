

import Foundation

extension UserDefaults {
    
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    
    func isTutorialShown() -> Bool {
        return self.bool(forKey: kIsTutorialAlreadyShown)
    }
    
    func setTutorialShownStatus(tutorialShown: Bool) {
        self.set(tutorialShown, forKey: kIsTutorialAlreadyShown)
        self.synchronize()
    }
    
    func isPermissionGranteed() -> Bool {
        return self.bool(forKey: kPermissionGranted)
    }
    
    func setPermissionStatus(tutorialShown: Bool) {
        self.set(tutorialShown, forKey: kPermissionGranted)
        self.synchronize()
    }
    
    func isUserLoggedIn() -> Bool {
        return self.bool(forKey: kIsUserLoggedIn)
    }
    
    func setUserLoggedIn(userLoggedIn: Bool) {
        self.set(userLoggedIn, forKey: kIsUserLoggedIn)
        self.synchronize()
    }
    
    
    func getNotiShown() -> Bool {
           return self.bool(forKey: "isNotiShown")
       }
       
       func setNotiShown(userLoggedIn: Bool = false) {
           self.set(userLoggedIn, forKey: "isNotiShown")
           self.synchronize()
       }
    
    func setLanguage(languageName: String) {
         self.set(languageName, forKey: "Lang")
         self.synchronize()
       }
       
       func getLanguageName() -> String? {
         let selectedName = self.string(forKey: "Lang")
         return selectedName
       }
    
    func getContactsShown() -> Bool {
        return self.bool(forKey: "isContactsShown")
    }
    
    func setContactsShown(userLoggedIn: Bool = false) {
        self.set(userLoggedIn, forKey: "isContactsShown")
        self.synchronize()
    }
    
    func isAppInstalled() -> Bool {
        return self.bool(forKey: kIsAppInstalled)
    }
    
    func setAppInstalled(installed: Bool) {
        self.set(installed, forKey: kIsAppInstalled)
        self.synchronize()
    }
    
    
    func getAccountVerified() -> Bool {
          return self.bool(forKey: "verifyAccount")
      }
      
      func setAccountVerified(installed: Bool = false) {
          self.set(installed, forKey: "verifyAccount")
          self.synchronize()
      }
    
    
    func getDetailsComplete() -> Bool {
             return self.bool(forKey: "detailsComplete")
         }
         
         func setDetailsComplete(installed: Bool = false) {
             self.set(installed, forKey: "detailsComplete")
             self.synchronize()
         }
    
    
    
    func getPinVerified() -> Bool {
             return self.bool(forKey: "pin")
         }
         
         func setPinVerified(installed: Bool = false) {
             self.set(installed, forKey: "pin")
             self.synchronize()
         }
    
    
    func setTokenOtp(loggedInAccessToken: String) {
                 self.set(loggedInAccessToken, forKey: "tokenOtp")
                 self.synchronize()
             }
             
             func getTokenOtp() -> String {
                 return String.getString(self.string(forKey: "tokenOtp"))
             }
    
    
    func setReligionID(loggedInAccessToken: String) {
                 self.set(loggedInAccessToken, forKey: "religionID")
                 self.synchronize()
             }
             
             func getReligionID() -> String {
                 return String.getString(self.string(forKey: "religionID"))
             }
    
//    func setMuslim(loggedInAccessToken: Bool) {
//                   self.set(loggedInAccessToken, forKey: "isMuslim")
//                   self.synchronize()
//               }
//
//               func getMuslim() -> Bool {
//                   return self.bool(forKey: "isMuslim")
//               }
//
    
    
    func setTeacherId(loggedInAccessToken: String) {
              self.set(loggedInAccessToken, forKey: "teacherID")
              self.synchronize()
          }
          
          func getTeacherId() -> String {
              return String.getString(self.string(forKey: "teacherID"))
          }
       
    
    func setChatId(loggedInAccessToken: String) {
                 self.set(loggedInAccessToken, forKey: "chatid")
                 self.synchronize()
             }
             
             func getChatId() -> String {
                 return String.getString(self.string(forKey: "chatid"))
             }
    
    
    func setCountry(loggedInAccessToken: String) {
                    self.set(loggedInAccessToken, forKey: "country")
                    self.synchronize()
                }
                
                func getCountry() -> String {
                    return String.getString(self.string(forKey: "country"))
                }
       
    
    
    func setUserID(loggedInAccessToken: String) {
           self.set(loggedInAccessToken, forKey: "userID")
           self.synchronize()
       }
       
       func getUserID() -> String {
           return String.getString(self.string(forKey: "userID"))
       }
    
    
    
    func setLoggedInAccessToken(loggedInAccessToken: String) {
        self.set(loggedInAccessToken, forKey: kLoggedInAccessToken)
        self.synchronize()
    }
    
    func getLoggedInAccessToken() -> String {
        return String.getString(self.string(forKey: kLoggedInAccessToken))
    }
    
    func setUserSelectedLocation(_ latitude: Double, _ longitude: Double) {
        self.set(latitude, forKey: kLatitude)
        self.set(longitude, forKey: kLongitude)
        self.synchronize()
    }
    
    func getSelectedLatitudeAndLongitude() -> (Double, Double) {
        return (Double.getDouble(self.double(forKey: kLatitude)), Double.getDouble(self.double(forKey: kLongitude)))
    }
    
    func updateLoggedInUserData(_ dict: Dictionary<String, Any>) {
        var dictUserData = getLoggedInUserDetails()
        for (key, value) in dict {
            dictUserData[key] = value
        }
        setLoggedInUserDetails(loggedInUserDetails: dictUserData)
    }
    
    func getLoggedInUserDetails() -> Dictionary<String, Any> {
        guard let dataUser = self.object(forKey: kLoggedInUserDetails) else {
            return ["":""]
        }
        
        guard let userData = dataUser as? Data else {
            return ["":""]
        }
        
        let unarchiver = NSKeyedUnarchiver(forReadingWith: userData)
        guard let userLoggedInDetails = unarchiver.decodeObject(forKey: kLoggedInUserDetails) as? Dictionary <String, Any> else {
            unarchiver.finishDecoding()
            return ["":""]
        }
        unarchiver.finishDecoding()
        return userLoggedInDetails
    }
    
    func setLoggedInUserDetails(loggedInUserDetails: Dictionary<String, Any>) {
        if loggedInUserDetails.isEmpty {
            self.set(nil, forKey: kLoggedInUserDetails)
            self.synchronize()
            return
        }
        
        let userData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: userData)
        archiver.encode(loggedInUserDetails, forKey: kLoggedInUserDetails)
        archiver.finishEncoding()
        self.set(userData, forKey: kLoggedInUserDetails)
        self.synchronize()
    }
    
    func setDeviceToken(deviceToken: String) {
        self.set(deviceToken, forKey: kDeviceToken)
        self.synchronize()
    }
    
    func getDeviceToken() -> String {
        return String.getString(self.string(forKey: kDeviceToken))
    }
    
    
    
}
