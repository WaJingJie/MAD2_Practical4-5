//
//  ShowContactViewController.swift
//  Telegramme
//
//  Created by MAD2 on 13/11/20.
//

import UIKit

class ShowContactViewController : UITableViewController{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var contactList:[Contact] = []
    let contactController:ContactController = ContactController();
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.reloadData()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let contacts = ContactController().retrieveAllContact(){
            contactList = contacts
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contactList[indexPath.row]
        cell.textLabel!.text = "\(contact.firstName)\(contact.lastName)"
        cell.detailTextLabel!.text = "\(contact.mobileNo)"
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle:
    UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        if indexPath.section == 0 {
            appDelegate.contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath],
            with: UITableView.RowAnimation.fade)		
        }
    else {
        
    tableView.deleteRows(at: [indexPath as IndexPath],
    with: UITableView.RowAnimation.fade)
    }
    } else if editingStyle == UITableViewCell.EditingStyle.insert {
    // Create a new instance of the appropriate class, insert it into the array,
    // and add a new row to the table view.
    }
    }
}
