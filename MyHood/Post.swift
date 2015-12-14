//
//  Post.swift
//  MyHood
//
//  Created by Chris Harrison on 11/12/2015.
//  Copyright © 2015 Chris Harrison. All rights reserved.
//

import Foundation


// Need to inherit NSObject and NScoding protocall in order to archive and save custom data
class Post: NSObject, NSCoding {
    private var _imagePath: String!
    private var _title: String!
    private var _postDescription: String!
    
    var imagePath: String {
        get {
            return _imagePath
        }
    }
    
    var title: String {
        get {
            return _title
        }
    }
    
    var postDescription: String {
        get {
            return _postDescription
        }
    }
    
    
    
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDescription = description
    }
    
    override init() {
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDescription = aDecoder.decodeObjectForKey("postDescription") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._postDescription, forKey: "postDescription")
        aCoder.encodeObject(self._title, forKey: "title")
        
    }
}