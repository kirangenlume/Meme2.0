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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes = [MemeObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimensions = (view.frame.size.width - (12 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensions, height: dimensions)
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailMemePage: MemeDetailPage = storyboard?.instantiateViewController(withIdentifier: "MeMeDetailImage") as! MemeDetailPage
        detailMemePage.memes = [memes[(indexPath as NSIndexPath).row]]
        self.navigationController!.pushViewController(detailMemePage, animated: true)
    }
}
