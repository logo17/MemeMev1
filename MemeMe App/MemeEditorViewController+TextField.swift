//
//  MemeEditorViewController+TextField.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/18/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import UIKit

extension MemeEditorViewController : UITextFieldDelegate {
    
    enum TextFieldType : Int {
        case top = 0, bottom
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (TextFieldType(rawValue: textField.tag)!) {
            case .top:
                meme.topText = textField.text
            case .bottom:
                meme.bottomText = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == MemeEditorViewController.defaultValueTopTextfield || textField.text == MemeEditorViewController.defaultValueBottomTextfield {
            textField.text = ""
        }
    }
    
}

