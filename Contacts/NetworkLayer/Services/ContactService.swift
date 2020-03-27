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
}


struct ContactService : ContactServiceProtocol {
    
    var httpClient : HTTPClientProtocol
    
    init(httpClient : HTTPClientProtocol) {
        self.httpClient  =   httpClient
    }
    
    func getContacts(completion: @escaping (Error?, [Contact]) -> Void) {
        httpClient.getData(urlString: EndPoint.Contacts.getContacts) { (data, error) in
            
        }
    }
}
