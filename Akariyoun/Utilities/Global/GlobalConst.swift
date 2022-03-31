


import UIKit

struct WTImage {
    static func images() -> [UIImage?] {return [UIImage(named: "art1"),UIImage(named: "art2"),UIImage(named: "art3")]}
    static func bgImage() -> CGImage? {return UIImage(named: "main_bg")?.cgImage}
}
//#563F8D
//struct GlobalColor {
//    static func themeColor() -> UIColor {return UIColor(hexString: "#563F8D")}
//    static func grayText() -> UIColor {return UIColor(hexString: "#7F7F7F")}
//    static func blackText() -> UIColor {return UIColor(hexString: "#333333")}
//    static func themeButtonText() -> UIColor {return UIColor(hexString: "#FFFFFF")}
//}

struct GlobalFont {
    static func poppinsMedium_16(size:CGFloat = 16) -> UIFont? {return UIFont(name: "Poppins-Medium", size: size)}
    static func poppinsBold_22(size:CGFloat = 22) -> UIFont? {return UIFont(name: "Poppins-Bold", size: size)}
    static func poppinsSemiBold_16(size:CGFloat = 16) -> UIFont? {return UIFont(name: "Poppins-SemiBold", size: size)}
    static func robotoBold(size:CGFloat) -> UIFont? {return UIFont(name: "Roboto-Bold", size: size)}
    static func robotoRegular_12(size:CGFloat = 12) -> UIFont? {return UIFont(name: "Roboto-Regular", size: size)}
    static func poppinsRegular_16(size:CGFloat = 16) -> UIFont? {return UIFont(name: "Poppins-Regular", size: size)}
    static func neyWorkSmallBold_28(size:CGFloat = 28) -> UIFont? {return UIFont(name: "NewYorkSmall-Bold", size: size)}
    static func neyWorkSmallMedium(size:CGFloat) -> UIFont? {return UIFont(name: "NewYorkSmall-Medium", size: size)}
}


struct GlobalAlertMessage {
    static func noInternet() -> String {return "Please Check Your Internet Connection & Try Again"}
    static func somethingWentWrong() -> String {return "Something Went Wrong Please Try Again"}
}

struct TextFieldImages {
    static func citizenship() -> UIImage? {return UIImage(named: "citizenship")}
    static func lock() -> UIImage? {return UIImage(named: "lock")}
    static func mail() -> UIImage? {return UIImage(named: "mail")}
    static func phone() -> UIImage? {return UIImage(named: "phone")}
    static func gender() -> UIImage? {return UIImage(named: "gender")}
    static func user() -> UIImage? {return UIImage(named: "user")}
    static func dropDownArrow() -> UIImage? {return UIImage(named: "dropDownArrow")}
    static func showPassword() -> UIImage? {return UIImage(named: "show")}
    static func hidePassword() -> UIImage? {return UIImage(named: "hide")}
}

struct GlobalAPIKeysValue {
    static func userType() -> Int {return 1}
    static func deviceType() -> Int {return 2}
    static func accountType() -> Int {return 1}
}

struct JSONKeys {
    static func message() -> String {return "message"}
}

struct Toast {
    static func duration() -> Double {return 0.7}
}


enum SB:String {
    case main = "Main"
    case home = "Home"
}



struct Params {
    struct Register {
        
        static func email()         -> String {return "email"}
        static func country_code()  -> String {return "country_code"}
        static func mobile()        -> String {return "mobile"}
        static func username()      -> String {return "username"}
        static func name()          -> String {return "name"}
        static func password()      -> String {return "password"}
        
        static func user_type() -> String {return "user_type"}
        static func account_type() -> String {return "account_type"}
        static func device_type() -> String {return "device_type"}
        static func device_token()  -> String {return "device_token"}
    }
    
    
    struct CreateProfile {
        static func gender() -> String {return "gender"}
        static func citizenship() -> String {return "citizenship"}
        static func citizenshipImage() -> String {return "national_id_img"}
        static func profileImage() -> String {return "profile_img"}
    }
    
    struct ResetPassword {
        static func password() -> String {return "password"}

    }
    static func deviceToken() -> String {return "dfvfvfdvdvfvdvfvf"}
    static func userTypeValue() -> String {return "1"}
    static func deviceType() -> String {return "2"}
    static func accountType() -> String {return "1"}
}

