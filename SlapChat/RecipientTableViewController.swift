//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Jhantelle Belleza on 11/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {

    var store = DataStore.sharedInstance
    var recipients: Recipient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.recipients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipientCell", for: indexPath)
        let selected = store.recipients[indexPath.row]
        cell.textLabel?.text = selected.name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMessage" {
        let destVC = segue.destination as! TableViewController
        let index = tableView.indexPathForSelectedRow?.row
        guard let unwrappedIndex = index else { return }
            destVC.messages = store.recipients[unwrappedIndex].messages?.allObjects as! [Message]
            destVC.selectedIndex = unwrappedIndex
        }
    }
}
