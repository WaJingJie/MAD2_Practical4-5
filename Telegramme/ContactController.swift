//
//  ContactController.swift
//  Telegramme
//
//  Created by MAD2 on 26/11/20.
//

import CoreData
import UIKit
class ContactController{
    
    var appDelegate:AppDelegate
    let context:NSManagedObjectContext
    
    init(){
        appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    //add a new contact to core data
    func addContact(newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let contactEntity = NSEntityDescription.entity(forEntityName: "CDCContact", in: context)!
        
        let contact = NSManagedObject(entity: contactEntity, insertInto: context)
        contact.setValue(newContact.firstName, forKeyPath: "firstname")
        contact.setValue(newContact.lastName, forKeyPath: "lastname")
        contact.setValue(newContact.mobileNo, forKeyPath:"mobileno")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //retrieve all contacts from core data
    func retrieveAllContact() -> [Contact]? {
        /*var contact:[NSManagedObject] = []
        var newContact:[Contact] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do{
            contact = try context.fetch(fetchRequest)
            
            for c in contact {
                let firstname = c.value(forKeyPath: "firstname") as? String
                let lastname = c.value(forKeyPath: "lastname") as? String
                let mobileno = c.value(forKeyPath: "mobileno") as? String
                print("\(firstname!)\(lastname)!,\(mobileno!)")
                
                let allContact:Contact = Contact(firstname: firstname!, lastname: lastname!, mobileno: mobileno!)
                newContact.append(allContact)
            }
            }catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return newContact*/
        
        let fetchReqeust = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCContact")
        
        //list contact
        var contactList:[Contact] = []
        
        do{
            let result = try context.fetch(fetchReqeust)
            for data in result as! [NSManagedObject]{
                let con:Contact = Contact(firstname: data.value(forKey: "firstname") as! String, lastname: data.value(forKey: "lastname") as! String, mobileno: data.value(forKey: "mobileno") as! String)
                contactList.append(con)
            }
            return contactList
        } catch {
            print("Failed")
            return nil
        }
        
        }
    
    
    //update current contact with new contact
    //fect data based on mobileno
    func updateContact(mobileno:String, newContact:Contact){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CDCContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        
        do{
            let result = try context.fetch(fetchRequest)
            
            let objectUpdate = result[0] as! NSManagedObject
            
            objectUpdate.setValue(newContact.firstName, forKey: "firstname")
            objectUpdate.setValue(newContact.lastName, forKey: "lastname")
            objectUpdate.setValue(newContact.mobileNo, forKey: "mobileno")
            
            do{
                try context.save()
            } catch{
                print(error)
            }
        } catch{
            print(error)
        }
    }
    
    //delete contact
    //fetch data based on mobileno
    func deleteContact(mobileno:String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        
        do{
            let result = try context.fetch(fetchRequest)
            
            let obejectDelete = result[0] as! NSManagedObject
            context.delete(obejectDelete)
            
        } catch{
            print(error)
        }
    }

}
