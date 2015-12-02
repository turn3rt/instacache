//
//  ProfileViewController.swift
//  Cash In
//
//  Created by David Fontenot on 12/2/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//
//Users/hellyeah/Dropbox/Projects/instacache/Cash In/Cash In/ProfileViewController.swift
import UIKit

class ProfileViewController: UIViewController {
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorBalance: UILabel!
    
    var localAPI = LocalAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shit happens
        //start polling vendor data
        //maybe do something similar to the twitter auth auto-jump to login page if you arent authed
        
        print(localAPI.vendorObject)
        
        
        profileImage.setImageWithURL(NSURL(string: "http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-2.jpg")!)
    }
    
    func saveNewData () {
        //posts new profile data to server
    }
    
    
    @IBAction func showCashSelectSheet(sender: UIButton) {
        let cashMenu = UIAlertController(title: nil, message: "Select The Amount Of Cash To Deliver", preferredStyle: .ActionSheet)
        let loadingAlert = UIAlertController(title: "Please Wait", message: "Searching to discover a Cash Out Customer", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Yes", style: .Default, handler: nil)
        
        
        let twentyDollars = UIAlertAction(title: "$20", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            //poss do asyc funcs? idk how to code that but it would give the vc time to initialize and find current loc & render map
            let vc = self.mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(loadingAlert, animated: true, completion: {() -> Void in
                sleep(2)
                self.dismissViewControllerAnimated(true, completion: {() -> Void in
                    self.showViewController(vc, sender: self)})
            print("20 Selected")
            })
        })
        let fourtyDollars = UIAlertAction(title: "$40", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let vc = self.mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(loadingAlert, animated: true, completion: {() -> Void in
                sleep(2)
                self.dismissViewControllerAnimated(true, completion: {() -> Void in
                    self.showViewController(vc, sender: self)})
                print("20 Selected")
            })
        })
        let sixtyDollars = UIAlertAction(title: "$60", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let vc = self.mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(loadingAlert, animated: true, completion: {() -> Void in
                sleep(2)
                self.dismissViewControllerAnimated(true, completion: {() -> Void in
                    self.showViewController(vc, sender: self)})
                print("20 Selected")
            })
        })
        let eightyDollars = UIAlertAction(title: "$80", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let vc = self.mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(loadingAlert, animated: true, completion: {() -> Void in
                sleep(2)
                self.dismissViewControllerAnimated(true, completion: {() -> Void in
                    self.showViewController(vc, sender: self)})
                print("20 Selected")
            })

        })
        let lotsOfDollars = UIAlertAction(title: "$100", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let vc = self.mainStoryboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(loadingAlert, animated: true, completion: {() -> Void in
                sleep(2)
                self.dismissViewControllerAnimated(true, completion: {() -> Void in
                    self.showViewController(vc, sender: self)})
                print("20 Selected")
            })

        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        cashMenu.addAction(twentyDollars)
        cashMenu.addAction(fourtyDollars)
        cashMenu.addAction(sixtyDollars)
        cashMenu.addAction(eightyDollars)
        cashMenu.addAction(lotsOfDollars)
        cashMenu.addAction(cancel)
        
        
        
        self.presentViewController(cashMenu, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //shit happens
    }
}
