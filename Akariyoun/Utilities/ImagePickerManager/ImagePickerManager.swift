

// MARK:- Permission in Info Plist
/*
 1- For Camera
 
 Key       :  Privacy - Camera Usage Description
 Value     :  $(PRODUCT_NAME) camera use
 
 2- For Gallery
 Key       :  Privacy - Photo Library Usage Description
 Value     :  $(PRODUCT_NAME) photo use
 
 */
import Foundation

var pickerCallBack:PickerImage = nil
typealias PickerImage = ((UIImage?,String) -> (Void))?

import UIKit

class ImagePickerHelper: NSObject {
    
    private override init() {
    }
    
    static var shared : ImagePickerHelper = ImagePickerHelper()
    var picker = UIImagePickerController()
    var pickerView:UIViewController?
    // MARK:- Action Sheet
    
    func showActionSheet(withTitle title: String?, withAlertMessage message: String?, withOptions options: [String],reference:UIViewController? , handler:@escaping (_ selectedIndex: Int) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for strAction in options {
            let anyAction =  UIAlertAction(title: strAction, style: .default){ (action) -> Void in
                return handler(options.firstIndex(of: strAction)!)
            }
            alert.addAction(anyAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) -> Void in
            return handler(-1)
        }
        alert.addAction(cancelAction)
        presetImagePicker(pickerVC: alert,reference: reference)
        
    }
    
    // MARK: Public Method
    
    /**
     
     * Public Method for showing ImagePicker Controlller simply get Image
     * Get Image Object
     */
    
    func showPickerController(reference:UIViewController? ,_ handler:PickerImage) {
        
        self.showActionSheet(withTitle: "Choose Option", withAlertMessage: nil, withOptions: ["Take Picture", "Open Gallery"], reference: reference){ ( _ selectedIndex: Int) in
            switch selectedIndex {
            case OpenMediaType.camera.rawValue:
                self.showCamera(reference: reference)
            case OpenMediaType.photoLibrary.rawValue:
                self.openGallery(reference: reference)
            default:
                break
            }
        }
        
        pickerCallBack = handler
    }
    
    
    
    func showMultipleImagePickerController(_ handler:PickerImage , reference:UIViewController? = UIApplication.shared.windows.first?.rootViewController) {
        
        self.showActionSheet(withTitle: "Choose Option", withAlertMessage: nil, withOptions: ["Take Picture", "Open Gallery"] ,reference: reference){ ( _ selectedIndex: Int) in
            switch selectedIndex {
            case OpenMediaType.camera.rawValue:
                self.showCamera(reference: reference)
            case OpenMediaType.photoLibrary.rawValue:
                self.openGallery(reference: reference)
            default:
                break
            }
        }
        
        pickerCallBack = handler
    }
    
    
    func showGalleryPickerController(reference:UIViewController? ,_ handler:PickerImage) {
        self.openGallery(reference: reference)
        pickerCallBack = handler
    }
    
    func showCameraPickerController(reference:UIViewController?,_ handler:PickerImage) {
        self.showCamera(reference: reference)
        pickerCallBack = handler
    }
    
    
    // MARK:-  Camera
    func showCamera(reference:UIViewController?) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .camera
            presetImagePicker(pickerVC: picker,reference: reference)
        } else {
            showAlertMessage.alert(message: "Camera not available.")
        }
        picker.delegate = self
    }
    
    
    // MARK:-  Gallery
    
    func openGallery(reference:UIViewController?) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        presetImagePicker(pickerVC: picker,reference: reference)
        picker.delegate = self
    }
    
    // MARK:- Show ViewController
    
    private func presetImagePicker(pickerVC: UIViewController,reference:UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> Void {
        self.pickerView = pickerVC
        reference?.present(pickerVC, animated: true, completion: {
            self.picker.delegate = self
        })
    }
    
    fileprivate func dismissViewController() -> Void {
        //reference:UIViewController? = UIApplication.shared.windows.first?.rootViewController
        //  let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.pickerView?.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK;- func for imageView in swift
    func SaveImage (imageView :UIImage) {
        UIImageWriteToSavedPhotosAlbum(imageView, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            showAlertMessage.alert(message: "Photos not Saved ")
        } else {
            showAlertMessage.alert(message: "Your altered image has been saved to your photos. ")
        }
    }
}


// MARK: - Picker Delegate
extension ImagePickerHelper : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     //    if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
                    
         //       }
        
        pickerCallBack?(image,"imageURL.path")
        
        dismissViewController()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissViewController()
    }
}



class TextFieldMargin: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//
//  Image Picker ViewControllerExtension.swift
//  TheFirstGuide
//
//  Created by Fluper's iMac 4 on 13/09/18.
//  Copyright © 2018 Fluper's iMac 4. All rights reserved.
//

import Foundation
import  UIKit


//MARK:- ImagePickerDelegate
protocol UIImagePickerDelegate {
    func imagePicker(_ picker: UIImagePickerController, didImagePick image: UIImage?)
}


extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showDocumentUploadController(_ imagePicker: UIImagePickerController,images: [UIImage]) {
        
        let message = ""
        let alertbox = UIAlertController(title: "",
                                         message: message,
                                         preferredStyle: .alert)
        
        //        UIAlertAction
        let action = UIAlertAction(title: "Camera",
                                   style: .default,
                                   handler: {
                                    _ in self.openCamera(imagePicker)
        }
        )
        action.setValue(images[0], forKey: "image")
        action.setValue(UIColor.gray, forKey: "titleTextColor")
        alertbox.addAction(action)
        
        let action2 = UIAlertAction(title: "Photo Library", style: .default, handler: {_ in self.openGallery(imagePicker)})
        action2.setValue(images[1], forKey: "image")
        action2.setValue(UIColor.gray, forKey: "titleTextColor")
        alertbox.addAction(action2)
        
        present(alertbox, animated: true, completion: nil)
    }
    
    func pickImage(_ imagePicker: UIImagePickerController) {
        let message     = "Complete action using"
        let alertbox    = UIAlertController(title           : "",
                                            message         : message,
                                            preferredStyle  : .actionSheet)
        let paragraphStyle          = NSMutableParagraphStyle()
        paragraphStyle.alignment    = NSTextAlignment.center
        
        let attributesMessage       : [NSAttributedString.Key : Any] =  [
            NSAttributedString.Key.paragraphStyle    : paragraphStyle,
            NSAttributedString.Key.foregroundColor   : UIColor.blue
        ]
        let attributedMessage       = NSAttributedString(string: message, attributes: attributesMessage)
        alertbox.setValue(attributedMessage, forKey: "attributedMessage")
        
        let action = UIAlertAction(title: "Camera", style: .default, handler: { _ in self.openCamera(imagePicker)})
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertbox.addAction(action)
        
        let action2 = UIAlertAction(title: "PhotoLibrary", style: .default, handler: {_ in self.openGallery(imagePicker)})
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        alertbox.addAction(action2)
        
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        action3.setValue(UIColor.blue, forKey: "titleTextColor")
        alertbox.addAction(action3)
        present(alertbox, animated: true, completion: nil)
    }
    
    //methods for image picker
    func openCamera(_ imagePicker: UIImagePickerController) {
        imagePicker.delegate        = self
        imagePicker.allowsEditing   = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType  = .camera
            imagePicker.delegate    = self
            self.present(imagePicker, animated: true, completion: {
                imagePicker.delegate = self
            })
        } else {
            showAlertMessage.alert(message: "Camera doesn't support this device.")
        }
    }
    
    func openGallery(_ imagePicker: UIImagePickerController) {
        imagePicker.allowsEditing   = false
        imagePicker.sourceType      = .photoLibrary
        self.present(imagePicker, animated: true, completion: {
            imagePicker.delegate    = self
        })
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        guard let viewC = self as? UIImagePickerDelegate else {return }
        viewC.imagePicker(picker, didImagePick: image)
    }
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
        guard let viewC = self as? UIImagePickerDelegate else {
            return
        }
        viewC.imagePicker(picker, didImagePick: nil)
    }
}


