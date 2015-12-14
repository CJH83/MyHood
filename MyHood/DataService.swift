//
//  DataService.swift
//  MyHood
//
//  Created by Chris Harrison on 13/12/2015.
//  Copyright © 2015 Chris Harrison. All rights reserved.
//

import Foundation
import UIKit


class DataService {
    static let instance: DataService = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts: [Post] = [Post]()
    
    
    var loadedPosts: [Post] {
        get {
            return _loadedPosts
        }
    }
    
    func savePosts() {
        //custom data and classes need to be converted to bytes in order to be saved
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func loadPosts() {
        //We then need to convert the loaded data(bits and bytes) back into an array
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
        
    }
    
    func saveImageAndCreatePath (image: UIImage) -> String {
        //pass in an image and convert the image to PNG data ready to be stored
        let imageData = UIImagePNGRepresentation(image)
        
        //create a unique name for the image by using NSDate
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate())"
        //create a full path for the image be calling documentsPathForFileName function and passing in the unique name for the image created above
        let fullPath = (documentsPathForFileName(imagePath))
        
        print("AAAAAA: \(fullPath)")
        imageData?.writeToFile(fullPath, atomically: true)
        
        return imagePath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
       
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    
    //Pass in unique image name as string.
    func documentsPathForFileName(name: String) -> String {
        // returns a path to the documents directory and stores it as an array in paths
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        //pull the full path out of the array and store in a variable cast as an NSString(object c)
        let fullPath = paths[0] as NSString
        // return the full path to the document directory and append the name of the image on to the end creating a path including the image name
        return fullPath.stringByAppendingPathComponent(name)
        
    }
    
}