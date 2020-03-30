//
//  Errors.swift
//  Contacts
//
//  Created by Nitish.kumar on 29/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

class Errors : Error {
    var message : String?
    
    var localizedDescription: String? {
        return self.message
    }
    
    init(message : String?) {
        self.message    =   message
    }
}
