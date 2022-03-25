

import Foundation
import UIKit

extension UIView {
        
    func drawShadowwithCornerWithradius(radius : CGFloat) {
           let layer = self.layer
        layer.shadowColor = #colorLiteral(red: 0.1333333333, green: 0.4705364108, blue: 0.7034772038, alpha: 0.5)
           layer.shadowOffset = CGSize(width: 1, height: 10)
        layer.shadowOpacity = 0.5
        //   layer.shadowRadius = radius
           layer.cornerRadius = radius
        layer.masksToBounds = false
       }
    
    func drawShadowwithCornerWithradius1(radius : CGFloat) {
              let layer = self.layer
           layer.shadowColor = #colorLiteral(red: 0.3215686275, green: 0.7137254902, blue: 0.6039215686, alpha: 1)
              layer.shadowOffset = CGSize(width: 1, height: 1)
              layer.shadowOpacity = 0.2
              layer.shadowRadius = radius
              layer.cornerRadius = radius
          }
       
    
    func drawShadowwithCornerWithradius2(radius : CGFloat) {
                 let layer = self.layer
              layer.shadowColor = #colorLiteral(red: 0.3215686275, green: 0.7137254902, blue: 0.6039215686, alpha: 1)
                 layer.shadowOffset = CGSize(width: 1, height: 1)
                 layer.shadowOpacity = 0.8
                 layer.shadowRadius = radius
                 layer.cornerRadius = radius
             }
          
    
    
    func drawShadowwithCorner() {
        let layer = self.layer
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 20
        layer.cornerRadius = 20
        layer.masksToBounds = false
    }
    
    
    func drawShadowwithCorner5() {
           let layer = self.layer
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 1)
           layer.shadowOpacity = 0.2
           layer.shadowRadius = 2
           layer.cornerRadius = 20
       }
    
    func drawShadowwithCorner6() {
              let layer = self.layer
              layer.shadowColor = UIColor.black.cgColor
              layer.shadowOffset = CGSize(width: 0, height: 1)
              layer.shadowOpacity = 0.2
              layer.shadowRadius = 2
              layer.cornerRadius = 10
          }
    
    func drawShadowwithCorner2() {
           let layer = self.layer
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 0)
           layer.shadowOpacity = 0.2
           layer.shadowRadius = 20
           layer.cornerRadius = 20
       }
    
    
    func drawShadowwithCorner1() {
           let layer = self.layer
        layer.shadowColor = UIColor.darkGray.cgColor
           layer.shadowOffset = CGSize(width: 1, height: 1)
           layer.shadowOpacity = 0.5
           layer.shadowRadius = 2
           layer.cornerRadius = 7
       }
    
    func addShadowOnSideViewInCell() {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
    }
    
    func drawShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    func drawShadow1() {
           let layer = self.layer
           layer.shadowColor = #colorLiteral(red: 0.9176470588, green: 0.02352941176, blue: 0.003921568627, alpha: 0.5)
           layer.shadowOffset = CGSize(width: 5, height: 5)
           layer.shadowOpacity = 0.3
           layer.shadowRadius = 5
           layer.masksToBounds = false
       }
    
    func removeShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0
        layer.shadowRadius = 5
    }
    
    func drawShadowOnCell() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 25
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3
    }
    
    
    @IBInspectable
    var cornerRadius1: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth1: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor1: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius1: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.9
            layer.shadowRadius = shadowRadius
        }
    }
    
}

extension UIButton {
    
    func drawShadowOnButton(cornerRadius:CGFloat = 20) {
        let layer = self.layer
       
        layer.shadowColor = #colorLiteral(red: 0.3215686275, green: 0.7137254902, blue: 0.6039215686, alpha: 1)
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
}

extension UIImageView {
    
    func drawShadowOnImage() {
        self.layer.cornerRadius = 7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
    }
    
}

extension UICollectionViewCell {
    
    func drawSadowOncollectionViewCell() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
}

extension UIView {
    
    //MARK: - Round corner method
    func maskingCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
