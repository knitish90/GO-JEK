//
//  NetworkHandler.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

typealias networkCompletion = ((_ data : Data?, _ error : Errors?)-> Void)
typealias Params = [String: String]

enum HTTPMethod: String {
    case GET    =   "GET"
    case POST   =   "POST"
    case PUT    =   "PUT"
    case DELETE =   "DELETE"
}


protocol HTTPClientProtocol {
    func getData(urlString : String, completion : @escaping networkCompletion)
    func postData(urlString : String, body : Data?, completion : @escaping networkCompletion)
    func updateData(urlString : String, body : Data?, completion : @escaping networkCompletion)
}


struct HTTPClient : HTTPClientProtocol {

    private let session : URLSession
    
    init(session : URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getData(urlString: String, completion:@escaping (Data?, Errors?) -> Void) {
       
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        guard let url = URLEncoder().encode(urlString, [:]) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue

        session.dataTask(with: request) { (data, response, error) in
            completion(data, nil)
        }.resume()
    }
    
    func postData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        
        guard let url = URL(string: urlString) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod  =   HTTPMethod.POST.rawValue
        request.httpBody    =   body
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            completion(data, nil)
        }.resume()
    }

    func updateData(urlString: String, body: Data?, completion: @escaping networkCompletion) {
        
        if Reachability.isConnectedToNetwork() == false {
            return completion(nil,Errors(message: Constants.NetworkError.internetConnectionError))
        }
        
        guard let url = URL(string: urlString) else {
            return completion(nil,Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod  =   HTTPMethod.PUT.rawValue
        request.httpBody    =   body
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            completion(data, nil)
        }.resume()
    }
}
