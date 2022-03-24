
import Foundation
import UIKit


// MARK: - Structure

//typealias  JSON = [String:Any]?

let kAppName                    = "Jachai"


let kSharedAppDelegate          = UIApplication.shared.delegate as? AppDelegate
@available(iOS 13.0, *)
let kSharedSceneDelegate        = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
let kSharedUserDefaults         = UserDefaults.standard
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height
let kRootVC                     = UIApplication.shared.windows.first?.rootViewController
let kBundleID                   = Bundle.main.bundleIdentifier!




func Localised(_ aString:String) -> String {
    
    return NSLocalizedString(aString, comment: aString)
}


let appThemeUp               = UIColor.init(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
let appThemeDown             = UIColor.init(red: 251/255, green: 136/255, blue: 51/255, alpha: 1)


