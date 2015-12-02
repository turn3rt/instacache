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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shit happens
        if (true) {
            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            //self.presentViewController(vc, animated: true, completion: nil)
            self.showViewController(vc, sender: self)
        }
    }
    
    func saveNewData () {
        //posts new profile data to server
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //shit happens
    }
}
