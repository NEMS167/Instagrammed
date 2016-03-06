//
//  azule.swift
//  
//
//  Created by Eileen Madrigal on 3/5/16.
//
//

import UIKit
import Parse

class azule: NSObject {
    
    var imageFile: PFFile?
    var caption: String?
    var author: PFUser?
    var createdAt: NSDate?
    
    init(obj: PFObject) {
        super.init()
        
        imageFile = obj["media"] as? PFFile
        caption = obj["caption"] as? String
        author = obj["author"] as? PFUser
        createdAt = obj.createdAt
        print(createdAt)
    }
    
    class func fetchPostsWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "azule")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    
    class func fetchSearchWithCompletion(search: String, completion:([PFObject]?, NSError?) -> ()){
        let query = PFQuery(className: "azule")
        query.whereKey("caption", containsString: search)
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    class func createPostArray(array: [PFObject]) -> [azule] {
        var posts = [azule]()
        for obj in array {
            posts.append(azule(obj: obj))
        }
        return posts
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "Post")
        
        // Add relevant fields to the object
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                media["media"] = PFFile(name: "image.png", data: imageData)
            }
        } else {
            media["media"] = nil
        }
        
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
}