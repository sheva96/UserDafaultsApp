//
//  StorageManager.swift
//  UserDafaultsApp
//
//  Created by Yevhen Shevchenko on 17.01.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    private let userDefautls = UserDefaults.standard
    private let key = "contact"
    
    /*
    func save(contact: String) {
        var contacts = fetchContacts()
        contacts.append(contact)
        userDefautls.setValue(contacts, forKey: key)
    }
    
    func fetchContacts() -> [String] {
        if let contacts = UserDefaults.standard.value(forKey: key) as? [String] {
            return contacts
        }
        return []
    }
    
    func delete(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        userDefautls.setValue(contacts, forKey: key)
    }
     */
    
    func save(contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefautls.set(data, forKey: key)
    }
    
    func fetchContacts() -> [Contact] {
        guard let data = userDefautls.object(forKey: key) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return []}
        
        return contacts
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefautls.set(data, forKey: key)
    }
}
