//
//  ImageDownloader.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

typealias imageComletion = (_ image : UIImage?,_ error : Error?)-> Void

class imageDownloader {
    
    static var handler : imageComletion!

    static let imageCache = NSCache<NSString, UIImage>()
    static let operationQueue = OperationQueue()
    
    class func downloadImage(imageUrl : String , indexPath : IndexPath?  = nil, handler : @escaping imageComletion) {
        self.handler    =   handler
        
        guard let url = URL(string: imageUrl) else {
            return self.handler(nil, Errors(message: Constants.NetworkError.inValidURLError))
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.handler?(cachedImage, nil)
        }else {
            let operation = BlockOperation()
            operation.addExecutionBlock {
                do {
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: "\(imageUrl)" as NSString)
                        handler(image,nil)
                    }
                    
                } catch {
                    return self.handler(nil, Errors(message: Constants.NetworkError.inValidURLError))
                }
            }
            imageDownloader.operationQueue.addOperation(operation)
        }
    }
}

