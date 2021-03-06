//
//  MessageTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 11/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewController: UITableViewController {
    @IBOutlet weak var InboxBarButton: UIBarButtonItem!
    @IBOutlet weak var OutboxBarButton: UIBarButtonItem!
    @IBOutlet var messagesTableView : UITableView?
    var messages: Array<Message> = []
    var userhandler = UserHandler()
    var inbox = true
    
    @IBAction func outboxButton(sender: UIBarButtonItem) {
        if self.inbox{
            self.getOutbox()
            self.inbox = false
            self.updateBarButtonStates()
        }
        //self.showAlert("outbox", message: "That worked, YAY!")
    }
    
    @IBAction func inboxButton(sender: AnyObject) {
        if !self.inbox{
            self.getInbox(self.userhandler.getUsername())
            self.inbox = true
            self.updateBarButtonStates()
        }
        //self.showAlert("inbox", message: "That worked, YAY!")
    }
    
    @IBAction func saveUserSettings(segue:UIStoryboardSegue) {
        // returning from settings
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateBarButtonStates()
        self.getInbox(self.userhandler.getUsername())
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController!.toolbarHidden = false
        if self.inbox{
            self.getInbox(self.userhandler.getUsername())
        }
        else{
            self.getOutbox()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.messages.count
        //return 1
    }
    
    func updateMessagesList(objects: AnyObject?){
        self.messages.removeAll(keepCapacity: false)
        if let objects = objects as? [PFObject] {
            for object in objects {
                let objectid = object.objectId
                let sender = object["sender"] as! String
                let recipient = object["recipient"] as! String
                let subject = object["title"] as! String
                let text = object["message"] as! String
                let timestamp = object.createdAt!
                
                self.messages.append(Message(objectid: objectid!, sender: sender, recipient: recipient, subject: subject, timestamp: timestamp, text: text))
            }
        }
        self.messages = Array(self.messages.reverse())
        //print("refreshed")
        self.tableView.reloadData()
    }
    
    func getInbox(recipient: String){
        // var user = PFUser.currentUser()
        let query = PFUser.query()!
        // let query = PFQuery(className:"messages")
        query.parseClassName = "messages"
        query.whereKey("recipient", equalTo: recipient)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil{
                self.updateMessagesList(objects)
            }
                
            else{
                print("Error")
            }
        }
    }
    
    func getOutbox(){
        let query = PFUser.query()!
        query.parseClassName = "messages"
        query.whereKey("sender", equalTo: self.userhandler.getUsername())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil{
                self.updateMessagesList(objects)
            }
                
            else{
                print("Error")
            }
        }
    }
    
    func refresh(sender:AnyObject){
        if self.inbox{
            self.getInbox(self.userhandler.getUsername())
        }
        else{
            self.getOutbox()
        }
        self.refreshControl?.endRefreshing()
    }
    
    func deleteParseMessage(id: String){
        let query = PFQuery(className:"messages")
        print(id, terminator: "")
        query.getObjectInBackgroundWithId(id) {
            (message: PFObject?, error: NSError?) -> Void in
            if error == nil && message != nil {
                message!.deleteInBackground()
            }
            else{
                self.showAlert("Error", message: error!.localizedDescription)
            }
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MessageTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageTableViewCell
        
        let message = self.messages[indexPath.row]
        
        cell.senderLabel.text = message.sender
        cell.textPreviewLabel.text = message.subject
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        cell.timestampLabel.text =  dateFormatter.stringFromDate(message.timestamp)

        return cell
    }
    
    func showAlert(title: String, message:String){
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // OK, do nothing
        }
        alertBox.addAction(OKAction)
        presentViewController(alertBox, animated: true, completion: nil)
    }
    
    func updateBarButtonStates(){
        self.InboxBarButton.enabled = !self.inbox
        self.OutboxBarButton.enabled = self.inbox
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let messageID = self.messages[indexPath.row].objectid
            self.deleteParseMessage(messageID)

            self.messages.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        if segue.identifier == "showMessage"{
            let messageViewController = segue.destinationViewController as! MessageViewController
            // Pass the selected object to the new view controller.
            if let indexPath =
                tableView.indexPathForCell(sender as! UITableViewCell) {
                    messageViewController.selectedMessage = messages[indexPath.row]
            }
        }
        
        
    }
    

}
