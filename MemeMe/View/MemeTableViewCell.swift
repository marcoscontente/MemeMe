//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Marcos Vinicius Goncalves Contente on 06/12/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    // MARK: - Data Source
    
    func fillCell(meme: Meme) {
        topTextLabel.text = meme.topText
        bottomTextLabel.text = meme.bottomText
        memeImageView.image = meme.memedImage
    }
}
