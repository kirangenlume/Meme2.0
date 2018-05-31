//
//  MemeCollectionViewController.swift
//  MeMe2.0
//
//  Created by kirang on 5/29/18.
//  Copyright © 2018 kirang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
    
    var memes = [MemeObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    // MARK: - Collection view data source


   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellView", for: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = memes[indexPath.item].memedImage
        return cell
    }

}
