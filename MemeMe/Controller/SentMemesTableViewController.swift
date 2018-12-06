//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Marcos Vinicius Goncalves Contente on 06/12/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var memes = Meme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")! as MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.memes = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
