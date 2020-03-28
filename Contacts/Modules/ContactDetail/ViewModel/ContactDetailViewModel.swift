//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactDetailViewModelProtocol {
    init(contact : Contact, service : ContactServiceProtocol)
    func getContactDetails()
    func makeFavourite()
}


class ContactDetailViewModel  : ContactDetailViewModelProtocol{
    
    var contactService : ContactServiceProtocol
    var contact : Contact
    required init(contact : Contact, service : ContactServiceProtocol) {
        contactService  =   service
        self.contact    =   contact
    }
    
    func getContactDetails() {
        
    }
    
    func makeFavourite() {
        
    }
    
    
}
