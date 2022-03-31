
//

import UIKit

class UIButtonBorderWidthAndColor: UIButtonCornerRadius {
   @IBInspectable override var borderWidth: CGFloat {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  @IBInspectable override var borderColor: UIColor? {
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
