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
    
    // MARK: - Data Source
    
    func fillCell(meme: Meme) {
        memeImageView.image = meme.memedImage
    }
}
