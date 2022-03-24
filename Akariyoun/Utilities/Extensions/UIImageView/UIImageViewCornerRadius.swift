

import UIKit

class UIImageViewCornerRadius: UIImageViewBorderWidthAndColor {
  @IBInspectable override var cornerRadius: CGFloat {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  @IBInspectable var asPerWidthCornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = (asPerWidthCornerRadius * kScreenWidth) / 320
      layer.masksToBounds = asPerWidthCornerRadius > 0
    }
  }
  @IBInspectable var makeCircle: Bool = false {
    didSet {
      layer.masksToBounds = cornerRadius > 0
    }
  }
}
