//
//  EditContactViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol EditContactVieModelProtocol : ContactDataBaseProtocol {
    func editContact()
    var didLoadingFailed : ((_ error : Errors?) -> Void)? { get set}
    var didLoadingSuccess : (()-> Void)? { get set}
}
class EditContactViewModel : BaseContactModel, EditContactVieModelProtocol {
    var contactService : ContactServiceProtocol
    
    var didLoadingFailed : ((_ error : Errors?) -> Void)?
    var didLoadingSuccess : (()-> Void)?
    
    required init(service: ContactServiceProtocol) {
        self.contactService =   service
        super.init(contact: Contact())
        
    }
    
  
    func editContact() {
        contactService.updateContact(self.contact) { (error, contact) in
            DispatchQueue.main.async {
                if error == nil, contact != nil {
                    self.contact    =   contact!
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
}
