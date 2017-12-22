//
//  ViewController+UIImagePickerControllerDelegate.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/18/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import UIKit

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shareButton.isEnabled = true
            imageView.image = selectedImage
            meme.originalImage = imageView.image
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
