//
//  ContactService.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactServiceProtocol {
    func getContacts(completion : @escaping (Errors?, [Contact]) -> Void)
    func contactDetails(contactId : Int, completion : @escaping (Errors?, Contact?)->Void)
    func addContact(_ contact: Contact, _ completion : @escaping (_ error: Errors?, _ contact : Contact?) -> Void)
    func updateContact(_ contact: Contact, _ completion : @escaping (_ error: Errors?, _ contact : Contact?) -> Void)
}


class ContactService : ContactServiceProtocol {
    
    var httpClient : HTTPClientProtocol
    var responseHandler : ResponseHandler!
    
    required init(httpClient : HTTPClientProtocol, handler : ResponseHandler = ResponseHandler()) {
        self.httpClient         =   httpClient
        self.responseHandler    =   handler
    }
    
    func getContacts(completion: @escaping (Errors?, [Contact]) -> Void) {
        httpClient.getData(urlString: EndPoint.Contacts.getContacts) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (contactList, error) in
                completion(error,contactList ?? [])
            }
        }
    }
    
    func contactDetails(contactId: Int, completion: @escaping (Errors?, Contact?) -> Void) {
        let urlString = EndPoint.Contacts.contactDetails.replace(of: "{contactId}", with: "\(contactId)")
                
        httpClient.getData(urlString: urlString) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
    
    func addContact(_ contact: Contact, _ completion : @escaping (_ error: Errors?, _ contact : Contact?) -> Void) {
        let urlString = EndPoint.Contacts.addContacts
        httpClient.postData(urlString: urlString, body: contact.encode()) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
    
    func updateContact(_ contact: Contact, _ completion : @escaping (_ error: Errors?, _ contact : Contact?) -> Void) {
        let urlString = EndPoint.Contacts.contactDetails.replace(of: "{contactId}", with: "\(contact.id)")
        httpClient.updateData(urlString: urlString, body: contact.encode()) { (data, error) in
            self.responseHandler.parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
}
