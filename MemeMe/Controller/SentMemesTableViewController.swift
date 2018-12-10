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
    
    // MARK: - Properties

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // MARK: - Initialize methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = appDelegate.memes[indexPath.row]
        cell.fillCell(meme: meme)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.memes = appDelegate.memes[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: - Action methods
    
    @IBAction func createNewMeme(_ sender: Any) {
        let memeEditorController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        if let navigationController = navigationController {
            navigationController.pushViewController(memeEditorController, animated: true)
        }
    }
}
