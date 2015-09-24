//
//  userHandler.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 15/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Parse



class UserHandler {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
/*
    func getUsername() -> String {
        var username = ""
        let fetchRequest = NSFetchRequest(entityName: "Settings")
        if let fetchResults = (try? self.managedObjectContext!.executeFetchRequest(fetchRequest)) as? [Settings] {
            if !fetchResults.isEmpty{
                username = fetchResults.last!.username
            }
        }
        return username
    }
    
    func getPassword() -> String {
        var password = ""
        let fetchRequest = NSFetchRequest(entityName: "Settings")
        if let fetchResults = (try? self.managedObjectContext!.executeFetchRequest(fetchRequest)) as? [Settings] {
            if !fetchResults.isEmpty{
                password = fetchResults.last!.password
            }
        }
        return password
    }
*/
    func getEmail() -> String {
        var email = ""
        let currentUser = PFUser.currentUser()
        if currentUser?.email != nil {
            email = (currentUser!.email)!
        }
        return email
    }
    
    func getUsername() -> String {
        var username = ""
        let currentUser = PFUser.currentUser()
        if currentUser?.username != nil {
            username = (currentUser!.username)!
        }
        return username
    }
    
    func getPassword() -> String {
        var password = ""
        let currentUser = PFUser.currentUser()
        if currentUser?.password != nil {
            password = (currentUser!.password)!
        }
        return password
    }
    
    func saveUserData(username: String, password: String) -> Bool{
        var error: NSError?
        let setting = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: self.managedObjectContext!) as! Settings
        setting.username = username
        setting.password = password
        do {
            try managedObjectContext?.save()
        } catch let error1 as NSError {
            error = error1
        }
        if error != nil{
            return false
        }
        else{
            return true
        }
    }
    
    func signUp(email: String, username: String, password: String){
        let user = PFUser()
        user.email = email
        user.username = username
        user.password = password
        print(email)
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }
    
    func logIn(email: String, username: String, password: String) {
        PFUser.logInWithUsernameInBackground(username, password: password){
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                print(error?.localizedDescription)
                // The login failed. Check error to see why.
            }
        }
    }
    
    
    
}