//
//  AddContactViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol AddContactViewModelProtocol  {
    init(service : ContactServiceProtocol)
    var contact : Contact! { get set }
    
    func viewDidLoad()
    func addContact()
}

class AddContactViewModel : AddContactViewModelProtocol{
    var contactService : ContactServiceProtocol
    var contact : Contact!
    
    required init(service: ContactServiceProtocol) {
        self.contactService =   service
    }
    
    func viewDidLoad() {
        addContact()
    }
    
    func addContact() {
        contactService.addContact(contact) { (error, contact) in
            
        }
    }
    
    
    
}
