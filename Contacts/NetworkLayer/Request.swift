//
//  Request.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET    =   "GET"
    case POST   =   "POST"
    case PUT    =   "PUT"
    case DELETE =   "DELETE"
}

protocol RequestProtocol {
    var url         : String            { get }
    var method      : HTTPMethod        { get }
    var bodyParams  : [String: Any]?    { get }
    var headers     : [String: String]? { get }
}


//extension made to make bodyParams and headers optional
extension RequestProtocol {
    var bodyParams  : [String: Any]?    { return nil }
    var headers     : [String: String]? { return nil }
}


