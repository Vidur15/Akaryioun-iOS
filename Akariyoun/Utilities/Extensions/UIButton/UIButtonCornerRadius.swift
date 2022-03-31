
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
