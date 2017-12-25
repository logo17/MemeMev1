//
//  SentMemesCollectionViewController.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/23/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController : UICollectionViewController {
    
    var memes : [Meme]!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFlowLayout(UIDevice.current.orientation.isLandscape)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initFlowLayout(_ isLanscape : Bool) {
        let space:CGFloat = 3.0
        
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        
        let dimensionW : CGFloat
        let dimensionH : CGFloat
        
        if isLanscape {
            dimensionH = (view.frame.size.width - (2 * space)) / 3.0
            dimensionW = (view.frame.size.height - (2 * space)) / 3.0
        } else {
            dimensionW = (view.frame.size.width - (2 * space)) / 3.0
            dimensionH = (view.frame.size.height - (2 * space)) / 3.0
        }
        collectionViewFlowLayout.itemSize = CGSize(width: dimensionW, height: dimensionH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        collectionViewCell.memeImage.image = memes[indexPath.row].memedImage
        return collectionViewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailFromCollectionView", sender: memes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromCollectionView" {
            let meme: Meme = sender as! Meme
            let detailVC = segue.destination as! MemeDetailViewController
            detailVC.meme = meme
        }
    }
    
}
