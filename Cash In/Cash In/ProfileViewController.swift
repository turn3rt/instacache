//
//  ProfileViewController.swift
//  Cash In
//
//  Created by David Fontenot on 12/2/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorBalance: UILabel!
    
    var vendor = Vendor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shit happens
        //start polling vendor data
        //maybe do something similar to the twitter auth auto-jump to login page if you arent authed
        
        print(vendor.vendorObject)
        
        if (true) {
            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            //self.presentViewController(vc, animated: true, completion: nil)
            self.showViewController(vc, sender: self)
        }
        
        profileImage.setImageWithURL(NSURL(string: "http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-2.jpg")!)
    }
    
    func saveNewData () {
        //posts new profile data to server
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //shit happens
    }
}
