//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Marcos Vinicius Goncalves Contente on 06/12/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var memedImageDetailView: UIImageView!{
        didSet {
            memedImageDetailView.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Properties

    var memes: Meme!
    
    // MARK: - Initialize methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImageDetailView.image = memes.memedImage
        tabBarShouldHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarShouldHidden(false)
    }
    
    // MARK: - Layout Settings Methods
    
    func tabBarShouldHidden(_ should: Bool) {
        tabBarController?.tabBar.isHidden = should
    }
    
}
