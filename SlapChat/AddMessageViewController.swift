//
//  ViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    var selectedRecipient = 0

    @IBOutlet weak var addMessageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func saveMessageButtonTapped(_ sender: AnyObject) {
        let store = DataStore.sharedInstance
        let context = store.persistentContainer.viewContext
        let newMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        guard let message = addMessageTextField.text else { return }
        newMessage.content = message
        newMessage.createdAt = NSDate()
        newMessage.recipient = store.recipients[selectedRecipient]
        store.saveContext()
        
        

            self.dismiss(animated: true, completion: nil)
        

//        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

