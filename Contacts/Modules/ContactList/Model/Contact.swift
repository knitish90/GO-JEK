//
//  Contact.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

protocol ContactDataBaseProtocol {
    var id          : Int {get set}
    var fullName    : String {get}
    var profileUrl  : String {get set}
    var isFavourite : Bool {get set}
    var firstName   : String {get set}
    var lastName    : String {get set}
    var emailId     : String {get set}
    var phone       : String {get set}
}
