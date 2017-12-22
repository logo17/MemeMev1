//
//  MemeEditorViewController.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/18/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    enum ImagePickerType : Int {
        case camera = 0, album
    }

    // MARK: Properties
    
    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme : Meme!
    static let defaultValueTopTextfield: String = "TOP"
    static let defaultValueBottomTextfield: String = "BOTTOM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meme = Meme()
        shareButton.isEnabled = false
        initTextFields(bottomTextField)
        initTextFields(topTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func initTextFields(_ textField: UITextField) {
        let textFieldAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white, NSAttributedStringKey.font.rawValue : UIFont(name: "Impact", size: CGFloat(40.0)) as Any, NSAttributedStringKey.strokeColor.rawValue : UIColor.black, NSAttributedStringKey.strokeWidth.rawValue : -5]
        textField.delegate = self
        textField.defaultTextAttributes = textFieldAttributes
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
    }
    
    func manageViewsVisibility(isHidden: Bool) {
        toolbar.isHidden = isHidden
        navigationBar.isHidden = isHidden
    }

    // MARK: Actions
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch (ImagePickerType(rawValue: sender.tag)!) {
            case .camera:
                imagePicker.sourceType = .camera
            case .album:
                imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openActivityView(_ sender: Any) {
        let memedImage : UIImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (type : UIActivityType?, completed : Bool?, items : [Any]?, error : Error?) in
            if completed ?? false {
                self.meme = Meme(topText: self.topTextField.text, bottomText: self.bottomTextField.text, originalImage: self.imageView.image, memedImage: memedImage)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func restartAppState(_ sender: Any) {
        topTextField.text = MemeEditorViewController.defaultValueTopTextfield
        bottomTextField.text = MemeEditorViewController.defaultValueBottomTextfield
        imageView.image = nil
        shareButton.isEnabled = false
        restartMemeModel()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func restartMemeModel() {
        meme = Meme(topText: "", bottomText: "", originalImage: nil, memedImage: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        manageViewsVisibility(isHidden: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        manageViewsVisibility(isHidden: false)
        return memedImage
    }
    
}

