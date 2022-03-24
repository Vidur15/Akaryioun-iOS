

import UIKit

class UIButtonSublayerBorderWidthAndColor: UIButtonBorderWidthAndColor {
  @IBInspectable var sublayerBorderWidth: CGFloat = 1 {
    didSet {
    }
  }
  @IBInspectable var sublayerBorderColorSelected: UIColor? {
    didSet {
    }
  }
  @IBInspectable var sublayerBorderColorNormal: UIColor? {
    didSet {
    }
  }
  @IBInspectable var leftSublayer: Bool = false {
    didSet {
    }
  }
  @IBInspectable var rightSublayer: Bool = false {
    didSet {
    }
  }
  @IBInspectable var bottomSublayer: Bool = false {
    didSet {
    }
  }
  @IBInspectable var topSublayer: Bool = false {
    didSet {
    }
  }
}
