//
//  SettingsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 14/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import CoreData
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var userhandler = UserHandler()
    
    @IBAction func signup(sender: UIButton) {
        let email = self.emailField.text
        let username = self.usernameField.text
        let password = self.passwordField.text
        if username != "" && password != "" && email != "" {
            userhandler.signUp(email!, username: username!, password: password!)
            self.showAlert("Success", message: "User created")
        }
        else {
            self.showAlert("Info", message: "You need to input both a username and password")
        }
    }

    func showAlert(title: String, message:String){
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // OK, do nothing
        }
        alertBox.addAction(OKAction)
        presentViewController(alertBox, animated: true, completion: nil)
    }
    
    
    func saveSettings() {
        let email = self.emailField.text
        let username = self.usernameField.text
        let password = self.passwordField.text
        if username != "" && password != "" {
            //if userhandler.saveUserData(username!, password: password!){
            //    userhandler.logIn(username!, password: password!)
            //}
            //else{
            //    self.showAlert("Error", message: "Something went wrong, user could not be changed")
            //}
            
            userhandler.logIn(email!, username: username!, password: password!)
        }
        else {
            self.showAlert("Info", message: "You need to input both a username and password")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.toolbarHidden = true
        self.emailField.text = userhandler.getEmail()
        self.usernameField.text = userhandler.getUsername()
        self.passwordField.text = userhandler.getPassword()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.saveSettings()
    }
    
    // Do not unwind segue if the user has not provided credentials
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if self.usernameField != nil{
            return true
        }
        else{
            return false
        }
    }
    

}
