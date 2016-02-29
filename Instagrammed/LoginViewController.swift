//
//  LoginViewController.swift
//  Instagrammed
//
//  Created by Eileen Madrigal on 2/29/16.
//  Copyright © 2016 Eileen Madrigal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Actions
    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if (user != nil) {
                print("you arelogged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Yay! User created successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
}