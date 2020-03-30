//
//  ContactListCellViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactListCellViewModelProtocol : ContactDataBaseProtocol {
    
}


struct ContactListCellViewModel : ContactListCellViewModelProtocol {
    
    var id: Int
    var fullName: String
    var profileUrl: String
    var isFavourite: Bool
    var firstName: String
    var lastName: String
    var emailId: String
    var phone: String
    var createdAt: String
    var updatedAt: String
    
    init(contact : Contact) {
        self.id             =   contact.id
        self.fullName       =   contact.fullName
        self.profileUrl     =   contact.profileImaeURl
        self.isFavourite    =   contact.favourite
        self.emailId        =   contact.email
        self.phone          =   contact.phoneNumber
        self.firstName      =   contact.firstName
        self.lastName       =   contact.lastName
        self.createdAt      =   contact.createdAt
        self.updatedAt      =   contact.updatedAt
    }
    
}
