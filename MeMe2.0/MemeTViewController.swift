//
//  MemeTViewController.swift
//  MeMe2.0
//
//  Created by kirang on 5/29/18.
//  Copyright © 2018 kirang. All rights reserved.
//

import UIKit

class MemeTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memes = [MemeObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCellView")
        let titleText = memes[indexPath.row].topText + " " + memes[indexPath.row].bottomText
        cell?.textLabel?.text = titleText
        
        let cellImage = memes[indexPath.row].memedImage
        cell?.imageView?.image = cellImage
        return cell!
    }

}
