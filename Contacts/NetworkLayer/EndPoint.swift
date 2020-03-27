//
//  EndPoint.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct EndPoint {
    static let baseURL = "http://gojek-contacts-app.herokuapp.com/contacts"
    
    struct Contacts {
        static let getContacts = EndPoint.baseURL + "/contacts.json"
    }
}
