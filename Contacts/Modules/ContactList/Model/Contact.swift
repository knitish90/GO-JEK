//
//  Contact.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation




struct Contact: Codable {
    var id: Int
    var firstName   =   ""
    var lastName    =   ""
    var email       =   ""
    var phoneNumber =   ""
    var profilePic  =   ""
    var favourite   =   false
    var createdAt, updatedAt: String!

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
        case favourite =   "favorite"
        case createdAt  =   "created_at"
        case updatedAt  =   "updated_at"
    }
    
    
    init(from decoder: Decoder) throws {
        let container       =   try decoder.container(keyedBy: CodingKeys.self)
        self.id             =   try container.parse(with: .id, Value: 0)
        self.firstName      =   try container.parse(with: .firstName, Value: "")
        self.lastName       =   try container.parse(with: .lastName, Value: "")
        self.email          =   try container.parse(with: .email, Value: "")
        self.phoneNumber    =   try container.parse(with: .phoneNumber, Value: "")
        self.profilePic     =   try container.parse(with: .profilePic, Value: "")
        self.favourite      =   try container.parse(with: .favourite, Value: false)
        self.createdAt      =   try container.parse(with: .createdAt, Value: "" )
        self.updatedAt      =   try container.parse(with: .updatedAt, Value: "")
        
    }
    
    init() {
        self.id = 0
    }
}


extension KeyedDecodingContainer {
    func parse<T>(with key: K, Value: T) throws -> T where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? Value
    }
}
