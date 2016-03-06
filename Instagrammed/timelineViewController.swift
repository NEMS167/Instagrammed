//
//  timelineViewController.swift
//  Instagrammed
//
//  Created by Eileen Madrigal on 3/5/16.
//  Copyright © 2016 Eileen Madrigal. All rights reserved.
//

import UIKit
import Parse

class timelineViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [azule]!
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 480
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        azule.fetchPostsWithCompletion { (posts: [PFObject]?, error: NSError?) -> () in
            if error == nil{
                self.posts = azule.createPostArray(posts!)
                self.tableView.reloadData()
            } else {
                print("No posts found")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! TimelineViewCell
        
        cell.post = posts[indexPath.row]
        
        return cell
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userLoggedOut", object: nil)
    }
    
}
