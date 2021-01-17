//
//  NewContactViewController.swift
//  UserDafaultsApp
//
//  Created by Yevhen Shevchenko on 17.01.2021.
//

import UIKit


protocol NewContactViewControllerDelegate {
    func saveContact(_ contact: Contact)
}

class NewContactViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var delegate: NewContactViewControllerDelegate!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.addTarget(self, action: #selector(firtNameDidChanged), for: .editingChanged)
    }

    @IBAction func barButtonsActions(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0: dismiss(animated: true)
        default: saveAndExit()
        }
    }
    
    @objc private func firtNameDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        saveButton.isEnabled = !firstName.isEmpty ? true : false
    }
    
    private func saveAndExit() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        let contact = Contact(firstName: firstName, lastName: lastName)
        StorageManager.shared.save(contact: contact)
        delegate.saveContact(contact)
        dismiss(animated: true)
    }
}
