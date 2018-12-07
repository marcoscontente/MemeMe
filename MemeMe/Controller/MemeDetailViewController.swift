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
    
    @IBOutlet weak var memedImageDetailView: UIImageView!
    
    var memes: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImageDetailView.image = memes.memedImage
        tabBarShouldHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarShouldHidden(false)
    }
    
    func tabBarShouldHidden(_ should: Bool) {
        tabBarController?.tabBar.isHidden = should
    }
    
}
