//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Marcos Vinicius Goncalves Contente on 06/12/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Initialize methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionCellsLayout(withSpace: 3.0)
    }
    
    // MARK: - CollectionViewDataSource Methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = appDelegate.memes[indexPath.row].memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    // MARK: - Layout Settings Methods
    
    func setCollectionCellsLayout(withSpace space: CGFloat) {
        var dimension = (view.frame.size.width - (2 * space)) / 3
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            dimension = (view.frame.size.width - (2 * space)) / 3
        } else {
            dimension = (view.frame.size.width - (2 * space)) / 5
        }
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}
