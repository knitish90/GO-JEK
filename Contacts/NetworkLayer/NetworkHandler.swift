//
//  NetworkHandler.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias networkCompletion = ((_ data : Data?, _ error : Error?)-> Void)

typealias Parameters = [String: String]
public typealias Headers    = [String: Any]?

enum ResponseType {
    case success, fail
}


protocol HTTPClientProtocol {
    func getData(urlString : String, completion : @escaping networkCompletion)
    func updateData(urlString : String, body : Data?, completion : @escaping networkCompletion)
}


struct HTTPClient : HTTPClientProtocol {
    private let session : URLSession
    
    init(session : URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getData(urlString: String, completion:@escaping (Data?, Error?) -> Void) {
       
        guard let url = URLEncoder().encodeUrl(urlString, [:]) else {
            return completion(nil,nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue

        session.dataTask(with: request) { (data, response, error) in
            completion(data,error)
        }.resume()
    }
    
    func updateData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        guard let url = URL(string: urlString) else {
            return completion(nil,nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod  =   HTTPMethod.PUT.rawValue
        request.httpBody    =   body
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            completion(data,error)
        }.resume()
    }
}
