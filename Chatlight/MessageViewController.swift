//
//  MessageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 14/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var selectedMessage: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.toolbarHidden = true
        self.subjectLabel.text = selectedMessage?.subject
        self.textField.text = selectedMessage?.text
        let timestamp = selectedMessage?.timestamp
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM yyyy 'at' HH:mm"
        
        self.timestampLabel.text =  dateFormatter.stringFromDate(timestamp!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
