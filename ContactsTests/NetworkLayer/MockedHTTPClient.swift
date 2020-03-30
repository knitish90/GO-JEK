//
//  MockedHTTPClient.swift
//  ContactsTests
//
//  Created by Nitish.kumar on 30/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
@testable import Contacts

class MockedHTTPClient : HTTPClientProtocol {
    
    private var jsonData : Data?
    private var error : Errors?
    
    init(mockedData : String?, error : Errors?) {
        self.jsonData =   mockedData?.data(using: .utf8)
        self.error  =   error
    }
    
    func getData(urlString: String, completion: @escaping networkCompletion) {
        completion(jsonData, nil)
    }
    
    func postData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        completion(jsonData, nil)
    }
    
    func updateData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        completion(jsonData, nil)
    }
}
