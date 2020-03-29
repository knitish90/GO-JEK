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
    
    override func getContacts(completion: @escaping (Error?, [Contact]) -> Void) {
        guard let data = responseString?.data(using: .utf8) else {
            return completion(Errors(message: Constants.NetworkError.inValidURLError), [])
        }
        ResponseHandler().parseResponse(data, nil) { (contactList, error) in
            completion(error, contactList ?? [])
        }
    }
    
    override func updateContact(_ contact: Contact, _ completion: @escaping (Error?, Contact?) -> Void) {
        
    }
    
    override func addContact(_ contact: Contact, _ completion: @escaping (Error?, Contact?) -> Void) {
        guard let data = contact.encode() else {
            return completion(Errors(message: Constants.NetworkError.inValidURLError),nil)
        }
        
        ResponseHandler().parseResponse(data, nil) { (contact, error) in
            completion(error,contact)
        }
        
        
    }
    
    override func contactDetails(contactId: Int, completion: @escaping (Error?, Contact?) -> Void) {
        ResponseHandler().parseResponse(responseString?.data(using: .utf8), nil) { (contact, error) in
            completion(error, contact)
        }
    }
}
