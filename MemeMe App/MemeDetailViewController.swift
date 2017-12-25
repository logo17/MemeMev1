//
//  MemeDetailViewController.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/25/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var memedImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memedImageview.image = meme.memedImage
    }
    
}
