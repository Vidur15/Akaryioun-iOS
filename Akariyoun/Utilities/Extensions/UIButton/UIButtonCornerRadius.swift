
//

import UIKit

class UIButtonCornerRadius: UIButton {
    @IBInspectable override var cornerRadius: CGFloat {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  @IBInspectable var makeCircle: Bool = false {
    didSet {
      layer.masksToBounds = cornerRadius > 0
    }
  }
}
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
//protocol Localizable {
//    var localized: String { get }
//}
//extension String: Localizable {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
//}
extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized()
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
   }
}

public protocol UITextFieldXIBLocalizable {
    var xibPlaceholderLocKey: String? { get set }
}

extension UITextField: UITextFieldXIBLocalizable {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized()
            let lang = kSharedUserDefaults.getLanguageName()
            if lang  == "ar"{
                self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
        }
    }
}


