//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var messages:[Message] = []
    var recipients:[Recipient] = []
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Fetching support
    
    func fetchData() {
        let context = persistentContainer.viewContext
        
        let recipientRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        
        do {
            recipients = try context.fetch(recipientRequest)
        } catch let error {
            print("Error fetching data: \(error)")
            recipients = []
        }

        if recipients.count == 0 {
            generateTestData()
        }
    }
    
    // MARK: - Core Data generation of test data
    
    func generateTestData() {
        let context = persistentContainer.viewContext
        
        let recipient: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
        
        recipient.name = "Doc McStuffins"
        recipient.email = "docmcstuffins@gmail.com"
        recipient.phoneNumber = "12345"
        
        saveContext()
        fetchData()
    }
    
}
