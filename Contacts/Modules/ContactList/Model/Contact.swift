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

struct Contact: Codable {
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
    
    
    init(from decoder: Decoder) throws {
        let container       =   try decoder.container(keyedBy: CodingKeys.self)
        self.id             =   try container.parse(with: .id, defaultValue: 0)
        self.firstName      =   try container.parse(with: .firstName, defaultValue: "")
        self.lastName       =   try container.parse(with: .lastName, defaultValue: "")
        self.email          =   try container.parse(with: .email, defaultValue: "")
        self.phoneNumber    =   try container.parse(with: .phoneNumber, defaultValue: "")
        self.profilePic     =   try container.parse(with: .profilePic, defaultValue: "")
        self.isFavorite     =   try container.parse(with: .isFavorite, defaultValue: false)
        self.createdAt      =   try container.parse(with: .createdAt, defaultValue: "" )
        self.updatedAt      =   try container.parse(with: .updatedAt, defaultValue: "")
        
    }
}


extension KeyedDecodingContainer {
    func parse<T>(with key: K, defaultValue: T) throws -> T
        where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
}
