
//
//611626599299-hbubgahn94uk7jlc9ig45o55v2qe8uu8.apps.googleusercontent.com
import Foundation
import UIKit


// MARK: - Structure

//typealias  JSON = [String:Any]?

let kAppName                    = "Jachai"
let kIsTutorialAlreadyShown     = "isTutorialAlreadyShown"
let kPermissionGranted          = "isPermissionGranted"
let kIsUserLoggedIn             = "isUserLoggedIn"
let kLoggedInAccessToken        = "access_token"
let kLoggedInUserDetails        = "loggedInUserDetails"
let kLoggedInUserId             = "loggedInUserId"
let kLatitude                   = "latitude"
let kLongitude                  = "longitude"
let kIsOtpVerified              = "is_mobile_verified"
let kIsProfileCreated           = "is_profile_create"
let kIs_Active                  = "is_active"
let kIs_Notification            = "is_notification"
let kIsAppInstalled             = "isAppInstalled"
let kAccessToken                = "token"
let kDeviceToken                = "device_token"
let iosDeviceType               = "1"
let iosDeviceTokan              = "123456789"
let kSharedAppDelegate          = UIApplication.shared.delegate as? AppDelegate
let kSharedInstance             = SharedClass.sharedInstance
@available(iOS 13.0, *)
let kSharedSceneDelegate        = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
let kSharedUserDefaults         = UserDefaults.standard
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height
let kRootVC                     = UIApplication.shared.windows.first?.rootViewController
let kBundleID                   = Bundle.main.bundleIdentifier!


struct APIUrl {
    //    static let kBaseUrl = "18.217.107.168:3010/user/"
    //    static let videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
}

struct Keys {
    static let kDeviceToken     = "deviceToken"
    static let kAccessToken     = "access_token"
    static let kFirebaseId      = "firebaseId"
    static let kMobileVerified  = "isMobileVerified"
    static let kUserName        = "username"
    static let alphabet         = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
}

struct ServiceName {
    
    static let signup               = "/customer/signUp"
    static let verifyOtp               = "/customer/verifyOtp"
    static let resend               = "/customer/resend"
    static let login               = "/customer/login"
    static let propertyList               = "/property/list"
    static let requestList               = "/requestList"
    static let memberList               = "/member/list"
    static let propertyDetails               = "/property/detail"
    static let logout               = "/customer/logout"
    static let addRequest               = "/customer/Request/add"
    static let memberDetails               = "/member/detail"
    
    static let newsList               = "/news?limit=1000&page"
     static let newsDetail               = "/newsdetail"
     static let aboutUs               = "/aboutUs"
    static let termsConditions               = "/termsConditions"
    static let privacyPolicy               = "/privacyPolicy"
    static let contactUs               = "/contactUs"

    static let governmentLoans               = "/governmentLoans"
    static let corporateLoans               = "/corporateLoans"
    static let acountSettings               = "/customer/acountSettings"
    static let profileDetails               = "/customer/profileDetails"
    static let bannerImage               = "/property/bannerImage"
    
     static let updateCoverPhoto               = "/customer/updateCoverPhoto"
    static let updateProfilePic               = "/customer/updateProfilePic"
     static let updateInfo               = "/customer/updateInfo"
    static let directories               = "/directories?limit=1000&page"
    
    
}


struct ApiParameters {
    static let providerType           = "provider_type"
    static let countryCode            = "country_code"
    static let mobileNumber           = "mobile_number"
    static let password               = "password"
    static let confirmPassword        = "confirm_password"
    static let deviceToken            = "device_token"
    static let deviceType             = "device_type"
    static let otp                    = "otp"
    static let userId                 = "user_id"
    static let name                   = "name"
    static let email                  = "email_address"
    static let dob                    = "dob"
    static let gender                 = "gender"
    static let profileImage           = "profile_image"
    static let houseNo                = "house_no"
    static let buildingName           = "building_name"
    static let society                = "society"
    static let pincode                = "pincode"
    static let latitude               = "latitude"
    static let longitude              = "longitude"
    static let deliveryCity           = "delivery_city"
    static let deliveryDistrict       = "delivery_district"
    static let addressType            = "address_type"
    static let tOtp                   = "TOTP"
    static let supportPin             = "support_pin"
    static let tfaOtp                 = "totp"
    static let pin                    = "pin"
    static let confirmPin             = "confirm_pin"
    static let type                   = "type"
}

struct NumberContants {
    static let kMinPasswordLength = 8
}

struct ColorSet {
    static let appTheamColor                  = UIColor.init(named: "AppTheamColor")
    static let appTheamGrayColor              = UIColor.init(named: "AppTheamGrayColor")
    static let appTheamLightGrayColor         = UIColor.init(named: "AppTheamLightGrayColor")
    static let appTheamLightColor             = UIColor.init(named: "AppTheamLightColor")
}

struct  AlertMessage {
    static let kDefaultError                  = "Something went wrong. Please try again."
    static let knoNetwork                     = "Please check your internet connection !"
    static let kSessionExpired                = "Your session has expired. Please login again. -> 🚀 "
    static let kNoInternet                    = "Unable to connect to the Internet. Please try again."
    static let kInvalidUser                   = "Oops something went wrong. Please try again later."
    static let knoData                        = "No Data Found 🎈"
    static let noName                         = "Empty name 🚀"
    static let Under_Development              = "Under Development 👨‍🏫"
    static let logout                         = "Are you sure you want to logout?"
    static let signin                         = "Please sign in first."
    static let currentPagealert               = "you are already on this page 🤣 -> 🚀"
}

struct Identifiers {
    static let kLoginVC                     = "LoginVC"
    static let kSignUpVC                    = "SignUpVC"
    static let tabBarController             = "JachaiTabBarViewController"
}

struct Storyboards {
    static let kMain                           = "Main"
    static let kHome                           = "Home"
}

enum HasCameFrom{
    case forgotPassword,SignUp,login,editProfile,twoFactor, none
}

struct Notifications {
    static let kDOB                             = "Please Enter Date of Birth"
    static let kEnterMobileNumber               = "Please Enter Mobile Number"
    static let kEnterValidMobileNumber          = "Please Enter Valid Mobile Number"
    static let kEnterEmail                      = "Please Enter your Email Id"
    static let kEnterValidEmail                 = "Please Enter Valid Email Id"
    static let kName                            = "Please Enter Name"
    static let kValidName                       = "Please Enter Valid Name"
    static let kPassword                        = "Please Enter Password"
    static let kConfirmPassword                 = "Please Enter Confirm Password"
    static let kValidPassword                   = "Password Should be of Minimum 8 characters Including Alphabets, Numbers & Special Characters."
    static let kNewPassword                     = "Please Enter New Password"
    static let kSamePassword                    = "Passwords should Match"
    static let kMatchPassword                   = "Password & Confirm Password doesn't Match"
    static let kTermsNCond                      = "Please Accept Terms & Conditions"
    static let kAppointment                     = "Please Enter Appointment Type"
    static let kUserType                        = "Please Enter Your User Type"
    static let kTnC                             = "Please Accept Terms & Conditions"
    
    
    static let houseNumber                      = "Please Enter House Number"
    static let buildingNumber                   = "Please Enter Building or Tower No."
    static let societyName                      = "Please Enter Society Name"
    
    static let authenticationType                = "Please Select Factor Verification Type"
    static let pin                              = "Please Enter Pin"
    static let confirmPin                       = "Please Enter Confirm Pin"
    static let validPin                       = "Pin & Confirm Pin doesn't Match"
}


struct AlertTitle {
    static let kOk                = "OK"
    static let kCancel            = "Cancel"
    static let kDone              = "Done"
    static let ChooseDate         = "Choose Date"
    static let SelectCountry      = "Select Country"
    static let logout             = "Logout"
    
}


struct CellIdentifier {
    static let kHomeSpecialitiesCollectionCell     = "HomeSpecialitiesCollectionViewCell"
    static let kHomeTopExpertsCollectionCell     = "HomeTopExpertsCollectionViewCell"
    static let kHomeExpertsTableCell     = "HomeExpertsTableViewCell"
    static let kExpertsListTableCell     = "ExpertsListTableViewCell"
}

struct OtherConstant {
    static let kAppDelegate        = UIApplication.shared.delegate as? AppDelegate
    // static let kRootVC             = UIApplication.shared.keyWindow?.rootViewController
    static let kBundleID           = Bundle.main.bundleIdentifier!
    static let kGenders: [String]  = ["Male", "Female", "Other"]
    static let kReviewsSortBy: [String] = ["Recent", "Last Month", "Last Year"]
}

func Localised(_ aString:String) -> String {
    
    return NSLocalizedString(aString, comment: aString)
}



struct Indicator {
    
    static func showToast(message aMessage: String)
    {
        DispatchQueue.main.async
        {
            showAlertMessage.alert(message: aMessage)
        }
    }
}

// Enums
enum PhotoSource {
    case library
    case camera
}

enum MessageType {
    case photo
    case text
    case video
    case audio
}

enum MessageOwner {
    case sender
    case receiver
}

enum BottomOptions: Int {
    case search = 0
    case match
    case message
    case post
}

//enum HasCameFrom{
//    case Forgot // forgot Password flow
//    case SignUp
//    case ResetPassword
//}

//enum AppColor {
//    case Blue, Red
//    var color : UIColor {
//        switch self {
//        case .Blue:
//            return UIColor.blue
//        case .Red:
//            return UIColor.init(hexString: "#C7003B")
//        }
//    }
//}


enum OpenMediaType: Int {
    case camera = 0
    case photoLibrary
    case videoCamera
    case videoLibrary
}



enum AppFonts {
    case bold(CGFloat),regular(CGFloat)
    var font:UIFont {
        switch self {
        case .bold(let size):
            return UIFont (name: "System", size: size)!
        case .regular(let size):
            return UIFont.systemFont(ofSize: size)
        }
    }
}



//// MARK: ---------Color Constants---------

let appThemeUp               = UIColor.init(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
let appThemeDown             = UIColor.init(red: 251/255, green: 136/255, blue: 51/255, alpha: 1)

struct CustomColor {
    
    static let kGreen               = UIColor.init(red: 50/255,  green: 185/255, blue: 113/255, alpha: 1)
    static let kRed                 = UIColor.init(red: 229/255,  green: 49/255, blue: 38/255, alpha: 1)
    static let kSenderPlay          = UIColor.init(red: 198/255,  green: 212/255, blue: 225/255, alpha: 0.4)
    static let kReceiverPlay        = UIColor.init(red: 115/255,  green: 120/255, blue: 128/255, alpha: 1)
    static let kBlack               = UIColor.init(red: 0/255,  green: 0/255, blue: 0/255, alpha: 0.05)
    static let kGray                = UIColor.init(red: 158/255,  green: 161/255, blue: 167/255, alpha: 1)
    static let kLightRed            = UIColor.init(red: 89/255,  green: 124/255, blue: 236/255, alpha: 1)
    static let kDarkRed             = UIColor.init(red: 57/255,  green: 83/255, blue: 164/255, alpha: 1)
    static let kChatHeader          = UIColor.init(red: 142/255,  green: 148/255, blue: 156/255, alpha: 1)
    
}

//MARK: ---------Method Constants---------


func print_debug(items: Any) {
    print(items)
}

func print_debug_fake(items: Any) {
}

let kLanguagesArray = [
    "Abkhazian",
    "Afar",
    "Afrikaans",
    "Akan",
    "Albanian",
    "Amharic",
    "Arabic",
    "Aragonese",
    "Armenian",
    "Assamese",
    "Avaric",
    "Avestan",
    "Aymara",
    "Azerbaijani",
    "Bambara",
    "Bashkir",
    "Basque",
    "Belarusian",
    "Bengali",
    "Bihari languages",
    "Bislama",
    "Bosnian",
    "Breton",
    "Bulgarian",
    "Burmese",
    "Catalan, Valencian",
    "Central Khmer",
    "Chamorro",
    "Chechen",
    "Chichewa, Chewa, Nyanja",
    "Chinese",
    "Church Slavonic, Old Bulgarian, Old Church Slavonic",
    "Chuvash",
    "Cornish",
    "Corsican",
    "Cree",
    "Croatian",
    "Czech",
    "Danish",
    "Divehi, Dhivehi, Maldivian",
    "Dutch, Flemish",
    "Dzongkha",
    "English",
    "Esperanto",
    "Estonian",
    "Ewe",
    "Faroese",
    "Fijian",
    "Finnish",
    "French",
    "Fulah",
    "Gaelic, Scottish Gaelic",
    "Galician",
    "Ganda",
    "Georgian",
    "German",
    "Gikuyu, Kikuyu",
    "Greek (Modern)",
    "Greenlandic, Kalaallisut",
    "Guarani",
    "Gujarati",
    "Haitian, Haitian Creole",
    "Hausa",
    "Hebrew",
    "Herero",
    "Hindi",
    "Hiri Motu",
    "Hungarian",
    "Icelandic",
    "Ido",
    "Igbo",
    "Indonesian",
    "Interlingua (International Auxiliary Language Association)",
    "Interlingue",
    "Inuktitut",
    "Inupiaq",
    "Irish",
    "Italian",
    "Japanese",
    "Javanese",
    "Kannada",
    "Kanuri",
    "Kashmiri",
    "Kazakh",
    "Kinyarwanda",
    "Komi",
    "Kongo",
    "Korean",
    "Kwanyama, Kuanyama",
    "Kurdish",
    "Kyrgyz",
    "Lao",
    "Latin",
    "Latvian",
    "Letzeburgesch, Luxembourgish",
    "Limburgish, Limburgan, Limburger",
    "Lingala",
    "Lithuanian",
    "Luba-Katanga",
    "Macedonian",
    "Malagasy",
    "Malay",
    "Malayalam",
    "Maltese",
    "Manx",
    "Maori",
    "Marathi",
    "Marshallese",
    "Moldovan, Moldavian, Romanian",
    "Mongolian",
    "Nauru",
    "Navajo, Navaho",
    "Northern Ndebele",
    "Ndonga",
    "Nepali",
    "Northern Sami",
    "Norwegian",
    "Norwegian Bokmål",
    "Norwegian Nynorsk",
    "Nuosu, Sichuan Yi",
    "Occitan (post 1500)",
    "Ojibwa",
    "Oriya",
    "Oromo",
    "Ossetian, Ossetic",
    "Pali",
    "Panjabi, Punjabi",
    "Pashto, Pushto",
    "Persian",
    "Polish",
    "Portuguese",
    "Quechua",
    "Romansh",
    "Rundi",
    "Russian",
    "Samoan",
    "Sango",
    "Sanskrit",
    "Sardinian",
    "Serbian",
    "Shona",
    "Sindhi",
    "Sinhala, Sinhalese",
    "Slovak",
    "Slovenian",
    "Somali",
    "Sotho, Southern",
    "South Ndebele",
    "Spanish, Castilian",
    "Sundanese",
    "Swahili",
    "Swati",
    "Swedish",
    "Tagalog",
    "Tahitian",
    "Tajik",
    "Tamil",
    "Tatar",
    "Telugu",
    "Thai",
    "Tibetan",
    "Tigrinya",
    "Tonga (Tonga Islands)",
    "Tsonga",
    "Tswana",
    "Turkish",
    "Turkmen",
    "Twi",
    "Uighur, Uyghur",
    "Ukrainian",
    "Urdu",
    "Uzbek",
    "Venda",
    "Vietnamese",
    "Volap_k",
    "Walloon",
    "Welsh",
    "Western Frisian",
    "Wolof",
    "Xhosa",
    "Yiddish",
    "Yoruba",
    "Zhuang, Chuang",
    "Zulu"
]
