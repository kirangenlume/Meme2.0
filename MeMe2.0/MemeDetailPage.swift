//
//  MemeDetailPage.swift
//  MeMe2.0
//
//  Created by kirang on 6/1/18.
//  Copyright © 2018 kirang. All rights reserved.
//

import UIKit

class MemeDetailPage: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    var memes = [MemeObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailImage?.image = memes[0].memedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
