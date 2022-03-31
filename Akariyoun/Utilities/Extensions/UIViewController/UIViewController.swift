
import Foundation
import UIKit



extension UIViewController{
    //    func goToHome(){
    //           let storyBoard = UIStoryboard(name: Storyboards.kHome, bundle: nil)
    //           guard  let vc = storyBoard.instantiateViewController(identifier: Identifiers.kHomeController) as? HomeViewController  else{return}
    //       self.navigationController?.pushViewController(vc, animated: true)
    //
    //       }
    
   
    
    
//    func addSheetToVC(sheet : SheetViewController){
//        sheet.allowPullingPastMaxHeight = false
//        sheet.allowPullingPastMinHeight = false
//           //  sheet?.hasBlurBackground = true
//        sheet.pullBarBackgroundColor = .clear
//        sheet.sheetViewController?.contentBackgroundColor  = .clear
//        sheet.cornerRadius = 50
//             sheet.dismissOnPull = true
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
    
    
    
    
    func getTableFooter(sender : UITableView) -> UIView{
           let tableFooterView:UIView = {
               let view1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
                view1.backgroundColor = .clear
               let activity = UIActivityIndicatorView.init(frame: CGRect.init(x: view1.frame.width / 2, y: view1.frame.height / 2, width: 40, height: 40))
                activity.color = UIColor.black
               activity.center = view1.center
                activity.startAnimating()
               view1.addSubview(activity)
                return view1
            }()
           return tableFooterView
       }
    
    
    
    func setStatusBarColor(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.1137254902, green: 0.3882352941, blue: 0.6431372549, alpha: 0.87)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    func setStatusBarColor1(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.1333333333, green: 0.4431372549, blue: 0.631372549, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
}



public extension UITextField {
    
    /// Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    //    func setPlaceHolderTextColor(_ color: UIColor) {
    //        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    //    }
    //
    //    /// Set placeholder text and its color
    //    func placeholder(text value: String, color: UIColor = .red) {
    //        self.attributedPlaceholder = NSAttributedString(string: value, attributes: [ NSAttributedString.Key.foregroundColor : color])
    //    }
    
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}



public extension UIViewController {
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = color
        overView.tag = tag
        self.view.addSubview(overView)
    }
}
