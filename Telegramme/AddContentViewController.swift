//
//  AddContentViewController.swift
//  Telegramme
//
//  Created by MAD2 on 12/11/20.
//

import UIKit

class AddContentViewController: UIViewController{
    
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var mobileFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        firstNameFld.text =  ""
        lastNameFld.text = ""
        mobileFld.text = ""
    }
    
    @IBAction func createFld(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        var contact:Contact = Contact(firstname: firstNameFld.text!, lastname: lastNameFld.text!, mobileno: mobileFld.text!)
        
        appDelegate.contactList.append(contact)
        print(String(appDelegate.contactList.count))
        
    }
}
