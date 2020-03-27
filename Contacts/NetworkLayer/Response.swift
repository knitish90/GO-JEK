//
//  Response.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias responseComletion<T> = (_ object : T?, _ error : Error?)->Void

protocol ResponseProtocol {
    func  parseResponse <T : Codable> (_ data : Data?,_ error : Error?, _ completion : responseComletion<T>)
}


struct Response : ResponseProtocol {
    func parseResponse<T>(_ data: Data?, _ error: Error?, _ completion: (T?, Error?) -> Void) where T : Decodable, T : Encodable {
        var response : T?
        if error == nil {
            do {
                response = try JSONDecoder().decode(T.self, from: data!)
                completion(response, nil)
            } catch let error  {
                completion(nil, error)
            }
        }
    }
}
