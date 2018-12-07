//
//  ViewController.swift
//  MemeMe
//
//  Created by Marcos V G Contente on 22/10/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var pickerViewController = UIImagePickerController()
    var memedImage: UIImage!
    let memeTextAttributes: [String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0,
        NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!
    ]
    
    // MARK: - Initialize methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewController.delegate = self
        setStartingUISettings()
        setTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        controllersBarsShouldAppears(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        controllersBarsShouldAppears(false)
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
        setStyle(toTextField: topTextField)
        setStyle(toTextField: bottomTextField)
    }
    
    func setStyle(toTextField textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.autocapitalizationType = .allCharacters
        textField.borderStyle = .none
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    func hideTopAndBottomBars(_ hide: Bool) {
        topToolBar.isHidden = hide
        bottomToolBar.isHidden = hide
    }
    
    func clear(text textField:UITextField) {
        textField.text = ""
    }
    
    func controllersBarsShouldAppears(_ appears: Bool) {
        navigationController?.navigationBar.isHidden = appears
        tabBarController?.tabBar.isHidden = appears
    }
    
    // MARK: - Action Methods
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        sender.title == "album" ? (pickerViewController.sourceType = .photoLibrary) : (pickerViewController.sourceType = .camera)
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        setStartingUISettings()
        clear(text: topTextField)
        clear(text: bottomTextField)
    }
    
    func save() {
        let meme = Meme(topText: topTextField.text!,
                        bottomText: bottomTextField.text!,
                        originalImage: imageView.image!,
                        memedImage: memedImage)
        appDelegate.memes.append(meme)
        
        let rootViewController = storyboard?.instantiateViewController(withIdentifier: "RootViewController") as! UITabBarController
        present(rootViewController, animated: true, completion: nil)
    }
    
    @IBAction func shareImage() {
        memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                self.cancel()
                return
            }
            self.save()
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        hideTopAndBottomBars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.imageView.frame, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        hideTopAndBottomBars(false)
        
        return memedImage
    }
   
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
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
        NotificationCenter.default.removeObserver(self)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardHeight = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
}

