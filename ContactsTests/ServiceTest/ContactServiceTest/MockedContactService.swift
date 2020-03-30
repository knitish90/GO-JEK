//
//  MockedContactService.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
@testable import Contacts

class MockedContactService : ContactService {
    
    var responseString : String?
    
    init(contactString : String?) {
        self.responseString = contactString
        super.init(httpClient: HTTPClient())
    }
    
    required init(httpClient: HTTPClientProtocol) {
        super.init(httpClient: httpClient)
    }
    
    override func getContacts(completion: @escaping (Errors?, [Contact]) -> Void) {
        ResponseHandler().parseResponse(responseString?.data(using: .utf8), nil) { (contactList, error) in
            completion(error, contactList ?? [])
        }
    }
    
    override func updateContact(_ contact: Contact, _ completion: @escaping (Errors?, Contact?) -> Void) {
        ResponseHandler().parseResponse(contact.encode(), nil) { (contact, error) in
            completion(error,contact)
        }
    }
    
    override func addContact(_ contact: Contact, _ completion: @escaping (Errors?, Contact?) -> Void) {
        ResponseHandler().parseResponse(contact.encode(), nil) { (contact, error) in
            completion(error,contact)
        }
    }
    
    override func contactDetails(contactId: Int, completion: @escaping (Errors?, Contact?) -> Void) {
        ResponseHandler().parseResponse(responseString?.data(using: .utf8), nil) { (contact, error) in
            completion(error, contact)
        }
    }
}
