//
//  MemeEditorViewController+TextFieldDelegate.swift
//  MemeMe
//
//  Created by Marcos Vinicius Goncalves Contente on 10/12/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit

extension MemeEditorViewController: UITextFieldDelegate {
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
