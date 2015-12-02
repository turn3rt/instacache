//
//  Helper.swift
//  Cash In
//
//  Created by Turner Thornberry on 12/2/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//



//ALL USEFUL RANDOM FUNCTIONS & SHIT GO HERE

import Foundation
import UIKit

class Helper: NSObject {
    
    class private var sharedInstance : Helper {
        struct Static {
            static let instance : Helper = Helper()
        }
        return Static.instance
    }
    
    class func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
