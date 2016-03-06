//
//  ImagepickerViewController.swift
//  Instagrammed
//
//  Created by Eileen Madrigal on 3/5/16.
//  Copyright © 2016 Eileen Madrigal. All rights reserved.
//

import UIKit
import Parse

class ImagepickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            //let newSize = CGSize(width: 320, height: 320)
            //photoView.image = self.resize(editedImage, newSize: newSize)
            currentImage.image = editedImage
    }
    
    
    
    @IBAction func selectCameraroll(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func postImageAction(sender: AnyObject) {
        if currentImage.image != nil {
            print("I'm posting")
           
            azule.postUserImage(currentImage.image!, withCaption: captionTextField.text) { (flag: Bool, error: NSError?) -> Void in
                if error == nil {
                    print("Image Posted Successfully!")
                    self.tabBarController?.selectedIndex = 0                    
                }
                else {
                    print("error occurred \(error?.localizedDescription)")
                }
            }
        }
       
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
  
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}