//
//  MemeViewController+UIImagePickerControllerDelegate.swift
//  MemeMe
//
//  Created by Marcos V G Contente on 23/10/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
}
