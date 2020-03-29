//
//  BaseContactModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol ContactDataBaseProtocol {
    var id          :   Int {get set}
    var firstName   :   String { get set}
    var lastName    :   String { get set}
    var fullName    :   String {get}
    var profileUrl  :   String {get set}
    var isFavourite :   Bool {get set}
    var emailId     :   String {get set}
    var phone       :   String {get set}
}

class BaseContactModel : ContactDataBaseProtocol{
    var contact : Contact
    var id: Int {
        get {
            self.contact.id
        }
        set {
            self.contact.id = newValue
        }
    }
    
    var fullName: String {
        get {
            self.contact.firstName + " " + self.contact.lastName
        }
    }
    
    var firstName : String {
        get {
            self.contact.firstName
        }
        set {
            self.contact.firstName  =   newValue
        }
    }
    
    var lastName : String {
        get {
            self.contact.lastName
        }
        set {
            self.contact.lastName   =   newValue
        }
    }
    var profileUrl: String {
        get {
            self.contact.profileImaeURl
        }
        set {
            self.contact.profilePic =   newValue
        }
    }
    
    var isFavourite: Bool {
        get {
            self.contact.favourite
        }
        set {
            self.contact.favourite  =   newValue
        }
    }
    
    var emailId: String {
        get {
            self.contact.email
        }
        set {
            self.contact.email  =   newValue
        }
    }
    
    var phone: String {
        get {
            self.contact.phoneNumber
        }
        set {
            self.contact.phoneNumber = newValue
        }
    }
    
    
    init(contact : Contact) {
        self.contact    =   contact
    }
}
