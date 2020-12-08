//
//  AddContentViewController.swift
//  Telegramme
//
//  Created by MAD2 on 12/11/20.
//

import UIKit
import CoreData

class AddContentViewController: UIViewController{
    
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var mobileFld: UITextField!

    var contact:Contact?
    let contactController:ContactController = ContactController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let con = contact{
            firstNameFld.text? = con.firstName
            lastNameFld.text? = con.lastName
            mobileFld.text? = con.mobileNo
        
	
        }
        else{

        }
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        clear()
    }
    
    @IBAction func createFld(_ sender: Any) {
        
        if (firstNameFld.text! != "" && lastNameFld.text! != "" && mobileFld.text! != ""){
            contactController.addContact(newContact: Contact(firstname: firstNameFld.text!, lastname: lastNameFld.text!, mobileno: mobileFld.text!))
            clear()
            print("Contact Created")
        }
    }
    
    func clear(){
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileFld.text = ""
    }
    
    func AddMessageToFriend(friend:Friend, message:Message){
        
    }
}
