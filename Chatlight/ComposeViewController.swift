/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ComposeViewController: UIViewController {

    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    @IBAction func sendButton(sender: UIButton) {
        self.sendMessage()
    }
    
    var userhandler = UserHandler()
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.toolbarHidden = true
        let myColor: UIColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1.0)
        self.messageField.layer.borderColor = myColor.CGColor
        self.messageField.layer.borderWidth = 0.5
        self.messageField.layer.cornerRadius = 8.0
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessage() {
        let message = PFObject(className:"messages")
        message["title"] = subjectField.text
        message["recipient"] = fromField.text
        message["sender"] = self.userhandler.getUsername()
        message["message"] = messageField.text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.showAlert("Sent", message: "The message has been sent")
            } else {
                self.showAlert("Fail", message: "The message was not sent")
            }
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
    
    
}
