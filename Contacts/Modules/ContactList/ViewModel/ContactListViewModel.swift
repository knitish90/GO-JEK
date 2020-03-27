//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

struct Contact: Encodable {
    let id: Int
    let firstName, lastName, email, phoneNumber: String
    let profilePic: String
    var isFavorite: Bool
    let createdAt, updatedAt: String

    var profileImaeURl: String {
        return EndPoint.baseURL + profilePic
    }
    
    var fullName : String {
        return firstName + " " + lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName  =   "first_name"
        case lastName   =   "last_name"
        case email
        case phoneNumber =  "phone_number"
        case profilePic =   "profile_pic"
        case isFavorite =   "favorite"
        case createdAt  =   "created_at"
        case updatedAt  =   "updated_at"
    }
}
