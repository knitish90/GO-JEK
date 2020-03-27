//
//  Section.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


class Section {
    var title : String
    var contacts : [Contact]
    
    init(title : String, contacts : [Contact]) {
        self.title      =   title
        self.contacts   =   contacts
    }
}


