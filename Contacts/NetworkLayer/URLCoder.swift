//
//  URLCoder.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation

//public struct URLEncoder {
//    static func encodeParameters(urlRequest : inout URLRequest, with params : Parameters) {
//        var components = URLComponents()
//        for (key,value) in params {
//            let queryItem = URLQueryItem(name: key, value: "\(value)")
//            components.queryItems?.append(queryItem)
//        }
//
//        urlRequest.url = components.url
//    }
//}
//

protocol URLEncoderProtocol {
    func encodeUrl(_ baseUrl : String,_ parameters: Parameters) -> URL?
}


class URLEncoder: URLEncoderProtocol {
    func encodeUrl(_ baseUrl: String, _ parameters: Parameters) -> URL? {
        var components = URLComponents()
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        var encodedParameters = components.url?.absoluteString ?? ""
        if encodedParameters == "?"{
            encodedParameters = ""
        }
        let encodedUrlString = baseUrl+encodedParameters
        return URL(string: encodedUrlString)
    }

}

