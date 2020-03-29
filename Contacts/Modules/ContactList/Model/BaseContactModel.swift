//
//  BaseContactModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation


protocol ContactDataBaseProtocol {
    var id          : Int {get}
    var fullName    : String {get}
    var profileUrl  : String {get}
    var isFavourite : Bool {get set}
    var emailId     : String {get}
    var phone       : String {get}
}

