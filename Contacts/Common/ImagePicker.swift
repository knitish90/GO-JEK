//
//  ImagePicker.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit


protocol ImagePickerDelegate : class{
    func didImageSelected(image: UIImage?)
}

open class ImagePicker : NSObject {
    
    private var pickerController: UIImagePickerController
    private weak var presentatingController: UIViewController?
    var didImageSelected : ((UIImage?)->Void)?
    weak var delegate : ImagePickerDelegate?
    
    init(controller : UIViewController, pickerController : UIImagePickerController) {
        self.presentatingController =   controller
        self.pickerController       =   pickerController
        super.init()
        
        self.pickerController.allowsEditing =   true
        self.pickerController.mediaTypes    =   ["public.image"]
    }
    
    func intializePicker() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

     
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.presentatingController?.present(alertController, animated: true)
    }
    
    
    private func action(for sourceType : UIImagePickerController.SourceType, title : String)-> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) {  _ in
            self.pickerController.sourceType = sourceType
            self.presentatingController?.present(self.pickerController, animated: true)
        }
    }
}
