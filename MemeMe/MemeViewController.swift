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
        startUISettings()
        setTextFields()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setDelegates() {
        pickerViewController.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    // MARK: - Setting UI
    
    func startUISettings() {
        shareButton.isEnabled = false
        imageView.image = UIImage(named: "camera")
    }
    
    func setTextFields() {
        topTextField.text = "top"
        bottomTextField.text = "bottom"
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
    
    
}

