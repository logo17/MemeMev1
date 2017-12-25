//
//  SentMemesTableViewController.swift
//  MemeMe App
//
//  Created by Heriberto Ureña madrigal on 12/23/17.
//  Copyright © 2017 Heriberto Ureña Madrigal. All rights reserved.
//

import Foundation
import UIKit
class SentMemesTableViewController : UITableViewController {
    
    var memes : [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView?.tableFooterView = UIView()
        tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SentMemesTableViewCell
        
        tableViewCell.memeText?.text = "\(memes[indexPath.row].topText ?? "") \( memes[indexPath.row].bottomText ?? "")"
        tableViewCell.memedImageview?.image = memes[indexPath.row].memedImage
        
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailFromTableView", sender: memes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromTableView" {
            let meme: Meme = sender as! Meme
            let detailVC = segue.destination as! MemeDetailViewController
            detailVC.meme = meme
        }
    }
    
}
