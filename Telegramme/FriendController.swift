//
//  FriendController.swift
//  Telegramme
//
//  Created by MAD2 on 9/12/20.
//


import UIKit
import CoreData

class FriendController{
    
    var appDelegate:AppDelegate
    let context:NSManagedObjectContext
    
    init(){
        appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
    }
    
    func AddFriend(friend:Friend){
        let fentity = NSEntityDescription.entity(forEntityName: "CDFriend", in: context)!
        
        let fobject = NSManagedObject(entity: fentity, insertInto: context)
        
        fobject.setValue(friend.name, forKey: "name")
        fobject.setValue(friend.profileImageName, forKey: "profileImageName")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func AddMessageToFriend(friend:Friend, message:Message){
        //new entity for message
        let mEntity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)!
        
        //friend record
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
        
        do{
            let friendlist = try context.fetch(fetchRequest)
            let friend = friendlist[0]
            
            let mObject = NSManagedObject(entity: mEntity, insertInto: context)
            mObject.setValue(message.sender, forKey: "isSender")
            mObject.setValue(message.text, forKey: "text")
            mObject.setValue(message.date, forKey: "date")
            mObject.setValue(friend, forKey: "friend")
            
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func retriveMessagesByFriend(friend:Friend) -> [Message]{
        //friend record
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
        
        var messages:[Message] = []
        
        do{
            let result = try context.fetch(fetchRequest)
            let friend = result[0] as! NSManagedObject
            
            let msglist = friend.value(forKey: "message")
            
            for f in msglist as! [NSManagedObject]{
                let messaage:Message = Message(t: f.value(forKey: "text") as! String, s: f.value(forKey: "isSender") as! Bool, d: f.value(forKey: "date") as! Date)
                
                messages.append(messaage)
            }
            
            return messages
        }catch{
            print("Fail")
            return []
        }
    }
    
}
