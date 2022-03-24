

import Foundation
import UIKit



extension UIViewController{

    
    func addBlurrView(blurView : UIView){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
               let blurEffectView = UIVisualEffectView(effect: blurEffect)
               blurEffectView.frame = blurView.bounds
               blurEffectView.backgroundColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
               blurEffectView.isOpaque = true
               blurEffectView.alpha = 0.75
               //     blurEffectView.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
               blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               blurView.addSubview(blurEffectView)
    }
    
    
    
//    func addSheetToVC(sheet : SheetViewController){
//        sheet.allowPullingPastMaxHeight = false
//        sheet.allowPullingPastMinHeight = false
//           //  sheet?.hasBlurBackground = true
//        sheet.pullBarBackgroundColor = .clear
//        sheet.sheetViewController?.contentBackgroundColor  = .clear
//        sheet.cornerRadius = 50
//             sheet.dismissOnPull = false
//             sheet.dismissOnOverlayTap = true
//             sheet.overlayColor = .clear
//
//             sheet.contentBackgroundColor = .clear
//
//        //     sheet?.treatPullBarAsClear = true
//
//             sheet.gripColor = .clear
//
//           //  sheet?.sheetViewController?.overlayColor = .clear
//
//
//             sheet.contentViewController.view.layer.shadowColor = UIColor.black.cgColor
//             sheet.contentViewController.view.layer.shadowOpacity = 0.1
//             sheet.contentViewController.view.layer.shadowRadius = 10
//             sheet.allowGestureThroughOverlay = true
//
//           //  self.sheet?.sheetViewController?.view.backgroundColor = .clear
//
//             _ = sheet.sizeChanged
//             sheet.sizeChanged = { sheet, size, height in
//                           print("Changed to \(size) with a height of \(height)")
//
//                         if height <= 650{
//                           //  self.change = false
//                              self.view.endEditing(true)
//                           //  kSharedAppDelegate?.window?.endEditing(true)
//                          //   nextvc.dropLocTextF.resignFirstResponder()
//                         }else{
//                         //     self.change = true
//                            // nextvc.changeSize()
//                         }
//               //  nextvc.changeSize()
//                       //    previousSizeChanged?(sheet, size, height)
//                       }
//
//             sheet.animateIn(to: self.view, in: self)
//    }
    func setStatusBarColor(){
          let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
          let statusBarColor = #colorLiteral(red: 0.1137254902, green: 0.3882352941, blue: 0.6431372549, alpha: 0.87)
          statusBarView.backgroundColor = statusBarColor
          view.addSubview(statusBarView)
      }
  
}



