//
//  MemeEditorViewController.swift
//  MeMe2.0
//
//  Created by kirang on 5/29/18.
//  Copyright © 2018 kirang. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottopTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    
    //Configuring TextFields
    func configure(textField: UITextField, withText text: String) {
        let memeTextAttributes: [String:Any] = [NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
                                                NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
                                                NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                                NSAttributedStringKey.strokeWidth.rawValue: -5]
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
    }
    
    //  MARK: View lifecycle Methods;
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(textField: topTextField, withText: "TOP")
        configure(textField: bottopTextField, withText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func save(){
        let meme = MemeObject(topText: topTextField.text!, bottomText: bottopTextField.text!, originalImage: selectedImage.image!, memedImage: generateMemedImage())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func hideTopAndBottomBars(_ hide: Bool) {
        topToolBar.isHidden = hide
        bottomToolbar.isHidden = hide
    }
    
    func generateMemedImage() -> UIImage {
        hideTopAndBottomBars(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideTopAndBottomBars(false)
        return memedImage
    }
    
    @IBAction func cancelSavedImage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exportImage(_ sender: Any) {
        let savedMeme: UIImage = generateMemedImage()
        
        let activityMemeEditorViewController: UIActivityViewController = UIActivityViewController(activityItems: [savedMeme], applicationActivities: nil)
        self.present(activityMemeEditorViewController, animated: true, completion: nil)
        
        activityMemeEditorViewController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                self.save()
                print("save successfully")
                activityMemeEditorViewController.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityMemeEditorViewController, animated: true, completion: nil)
    }
    
    //MARK:  barbutton methods
    @IBAction func clickCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        presentImagePickerWith(sourceType: .savedPhotosAlbum)
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let MemeEditorViewController = UIImagePickerController()
        MemeEditorViewController.delegate = self
        MemeEditorViewController.sourceType = sourceType
        present(MemeEditorViewController, animated:true, completion: nil)
    }
    
    //MARK: imagePicker Delegate Metods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage.contentMode = .scaleAspectFit
            selectedImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: textField delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ["TOP", "BOTTOM"].contains(textField.text!) {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Keyboard Methods
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottopTextField.isFirstResponder {
                view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottopTextField.isFirstResponder {
                view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: notification Methods
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

