//
//  TableViewController.swift
//  UserDafaultsApp
//
//  Created by Yevhen Shevchenko on 17.01.2021.
//

import UIKit


class ContactsTableViewController: UITableViewController {
    
    private var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = StorageManager.shared.fetchContacts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactVC = segue.destination as! NewContactViewController
        newContactVC.delegate = self
    }
}


// MARK: - Table view data source

extension ContactsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let contact = contacts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = contact.fullName
        
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - Table view delegate

extension ContactsTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteContact(at: indexPath.row)
        }
    }
}

// MARK: - NewContactViewControllerDelegate

extension ContactsTableViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
