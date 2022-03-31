

import Foundation
import UIKit

extension UITextField {
    func changeBorderColorOnTextFieldBeginEditing() {
        layer.borderColor = UIColor.init(red: 0, green: 0.5137, blue: 0.560, alpha: 1).cgColor
    }
    func changeBorderColorOnTextFieldEndEditing() {
        layer.borderColor = UIColor.init(red: 0.667, green: 0.667, blue: 0.667, alpha: 1).cgColor
    }
    
}
