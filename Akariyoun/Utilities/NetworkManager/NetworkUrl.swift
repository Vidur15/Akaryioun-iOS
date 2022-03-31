

import Foundation
import UIKit

/** --------------------------------------------------------
 * HTTP Basic Authentication
 *	--------------------------------------------------------
 */

let kHTTPUsername               = ""
let kHTTPPassword               = ""
let OS                          = UIDevice.current.systemVersion
let kAppVersion                 = "1.0"
let kDeviceModel                = UIDevice.current.model
let kRegularFont                = UIFont.init(name: "semi-regular", size: 14.0)
let kResult                     = "results"

/** --------------------------------------------------------
 *	 API Base URL defined by Targets.
 *	--------------------------------------------------------
 */
//http://3.143.37.165:4040/api/student/addStudent

let kImageDownloadURL         = "http://3.108.14.43/api/user/"
let kBASEURL                  = "https://appsinvo.co.uk/akariyoun-api/api"
let kAuthentication           = "Authentication"      // Header key of request  encrypt data
let kEncryptionKey            = ""                    // Encryption key replace this with your projectname

/** ************************************************************************** */
/* Entry/exit trace macros                                                   */
/** ************************************************************************** */
// #define TRC_ENTRY()    DDLogVerbose(@"ENTRY: %s:%d:", __PRETTY_FUNCTION__,__LINE__);
// #define TRC_EXIT()     DDLogVerbose(@"EXIT:  %s:%d:", __PRETTY_FUNCTION__,__LINE__);


/** --------------------------------------------------------
 *        Used Web Services Name
 *    --------------------------------------------------------
 */
let kKey                        = "key"
let kSignup                     = "signup"


