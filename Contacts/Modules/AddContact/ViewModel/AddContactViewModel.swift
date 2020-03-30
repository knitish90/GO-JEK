//
//  AddContactViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol AddContactViewModelProtocol : ContactDataBaseProtocol {
    func viewDidLoad()
    func addContact()
    
    var didLoadingFailed : ((_ error : Errors?) -> Void)? { get set}
    var didLoadingSuccess : (()-> Void)? { get set}
}

class AddContactViewModel : BaseContactModel, AddContactViewModelProtocol{
    var contactService : ContactServiceProtocol
    
    var didLoadingFailed : ((_ error : Errors?) -> Void)?
    var didLoadingSuccess : (()-> Void)?
    
    required init(service: ContactServiceProtocol) {
        self.contactService =   service
        super.init(contact: Contact())
    }
    
    func viewDidLoad() {
        addContact()
    }
    
    func addContact() {
        contactService.addContact(self.contact) { (error, contact) in
            DispatchQueue.main.async {
                if error == nil, contact != nil {
                    self.contact = contact!
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
    
    
    
}
