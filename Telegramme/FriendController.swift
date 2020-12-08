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
    
}
