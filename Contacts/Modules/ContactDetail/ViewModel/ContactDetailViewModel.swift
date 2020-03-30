//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactDetailViewModelProtocol : ContactDataBaseProtocol{
    func viewDidLoad()
    func getContactDetails()
    func makeFavourite()
    var didLoadingFailed : ((_ error : Error?) -> Void)? { get set}
    var didLoadingSuccess : (()-> Void)? { get set}
}


class ContactDetailViewModel  : BaseContactModel, ContactDetailViewModelProtocol{

    var didLoadingFailed    : ((Error?) -> Void)?
    var didLoadingSuccess   : (() -> Void)?
    
    
    var contactService  :   ContactServiceProtocol
    var contactId       :   Int
    
    required init(contactId : Int, service : ContactServiceProtocol) {
        contactService  =   service
        self.contactId  =   contactId
        super.init(contact: Contact())
    }
    
    func viewDidLoad() {
        getContactDetails()
    }
    
    func getContactDetails() {
        contactService.contactDetails(contactId: contactId) { (error, contact) in
            DispatchQueue.main.async {
                if error == nil {
                    self.contact    =   contact!
                    print(contact!)
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }
    
    func makeFavourite() {
        contactService.updateContact(contact) { (error, contact) in
            DispatchQueue.main.async {
                if error == nil {
                    self.contact    =   contact!
                    self.didLoadingSuccess?()
                }else {
                    self.didLoadingFailed?(error)
                }
            }
        }
    }    
}


