//
//  ViewController.swift
//  MemeMe
//
//  Created by Marcos V G Contente on 22/10/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var pickerViewController = UIImagePickerController()
    
    // MARK: - Initialize methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingUISettings()
        setTextFields()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func setDelegates() {
        pickerViewController.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Setting UI
    
    func setStartingUISettings() {
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        imageView.image = UIImage(named: "camera")
    }
    
    func setTextFields() {
        setDefaultTexts()
        let attributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0,
            NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!
        ]
        topTextField.defaultTextAttributes = attributes
        bottomTextField.defaultTextAttributes = attributes
        topTextField.autocapitalizationType = .allCharacters
        bottomTextField.autocapitalizationType = .allCharacters
        topTextField.borderStyle = .none
        bottomTextField.borderStyle = .none
        topTextField.adjustsFontSizeToFitWidth = true
        bottomTextField.adjustsFontSizeToFitWidth = true
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
    }
    
    func setDefaultTexts() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    // MARK: - Action Methods
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        sender.title == "album" ? (pickerViewController.sourceType = .photoLibrary) : (pickerViewController.sourceType = .camera)
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        setStartingUISettings()
        setDefaultTexts()
    }
    
    // MARK: - UIImagePickerController Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled = true
            topTextField.isEnabled = true
            bottomTextField.isEnabled = true
        }
    }
   
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topTextField.text == "" {
            topTextField.text = "TOP"
        }
        if bottomTextField.text == "" {
            bottomTextField.text = "BOTTOM"
        }
    }

    // MARK: - Keyboard Notifications
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardHeight = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
}

