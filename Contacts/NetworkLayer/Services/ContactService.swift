//
//  ContactService.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactServiceProtocol {
    init(httpClient : HTTPClientProtocol)
    func getContacts(completion : @escaping (Error?, [Contact]) -> Void)
    func contactDetails(contactId : Int, completion : @escaping (Error?, Contact?)->Void)
    func addContact(_ contact: Contact, _ completion : @escaping (_ error: Error?, _ contact : Contact?) -> Void)
    func updateContact(_ contact: Contact, _ completion : @escaping (_ error: Error?, _ contact : Contact?) -> Void)
}


struct ContactService : ContactServiceProtocol {
    
    var httpClient : HTTPClientProtocol
    
    init(httpClient : HTTPClientProtocol) {
        self.httpClient  =   httpClient
    }
    
    func getContacts(completion: @escaping (Error?, [Contact]) -> Void) {
        httpClient.getData(urlString: EndPoint.Contacts.getContacts) { (data, error) in
            Response().parseResponse(data, error) { (contactList, error) in
                completion(error,contactList ?? [])
            }
        }
    }
    
    func contactDetails(contactId: Int, completion: @escaping (Error?, Contact?) -> Void) {
        let urlString = EndPoint.Contacts.contactDetails.replace(of: "{contactId}", with: "\(contactId)")
                
        httpClient.getData(urlString: urlString) { (data, error) in
            Response().parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
    
    func addContact(_ contact: Contact, _ completion : @escaping (_ error: Error?, _ contact : Contact?) -> Void) {
        let urlString = EndPoint.Contacts.addContacts
        httpClient.postData(urlString: urlString, body: contact.encode()) { (data, error) in
            Response().parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
    
    func updateContact(_ contact: Contact, _ completion : @escaping (_ error: Error?, _ contact : Contact?) -> Void) {
        let urlString = EndPoint.Contacts.contactDetails.replace(of: "{contactId}", with: "\(contact.id)")
        httpClient.updateData(urlString: urlString, body: contact.encode()) { (data, error) in
            Response().parseResponse(data, error) { (contact, error) in
                completion(error, contact)
            }
        }
    }
}
