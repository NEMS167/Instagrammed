//
//  TimelineViewCell.swift
//  Instagrammed
//
//  Created by Eileen Madrigal on 3/5/16.
//  Copyright © 2016 Eileen Madrigal. All rights reserved.
//

import UIKit
import Parse

class TimelineViewCell: UITableViewCell{

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: azule! {
        didSet {
            captionLabel.text = post.caption
            if let file = post.imageFile {
                file.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        self.photoView.image = UIImage(data: data!)!
                        print("Set the image")
                    } else {
                        print(error?.localizedDescription)
                    }
                })
               
                
            }
            
        }
}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}