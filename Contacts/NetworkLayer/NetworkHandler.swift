//
//  NetworkHandler.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias networkCompletionHandler = ((_ data : Data?, _ error : Error?)-> Void)

enum ResponseType {
    case success, fail
}


protocol HTTPClientProtocol {
    func getData(urlString : String, completion : @escaping networkCompletionHandler)
}


struct HTTPClient : HTTPClientProtocol {
    
    private let session : URLSession
    
    init(session : URLSession) {
        self.session = session
    }
    
    func getData(urlString: String, completion:@escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: URL(fileURLWithPath: urlString))
        request.httpMethod = HTTPMethod.GET.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data,error)
        }.resume()
    }
}
