//
//  EditContactViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol EditContactVieModelProtocol {
    init(service : ContactServiceProtocol)
    func editContact()
}
class EditContactViewModel : EditContactVieModelProtocol {
    var contactService : ContactServiceProtocol
    
    required init(service: ContactServiceProtocol) {
        self.contactService =   service
    }
    
    func editContact() {
        //contactService.updateContact(<#T##contact: Contact##Contact#>, <#T##completion: (Error?, Contact?) -> Void##(Error?, Contact?) -> Void#>)
    }
    
}
