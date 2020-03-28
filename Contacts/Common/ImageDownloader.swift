//
//  ImageDownloader.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

typealias imageDownloaderHandler = (_ image : UIImage?,_ error : Error?)-> Void

class imageDownloader {
    
    static var handler : imageDownloaderHandler?

    static let imageCache = NSCache<NSString, UIImage>()
    static let operationQueue = OperationQueue()
    
    class func downloadImage(imageUrl : String , indexPath : IndexPath?  = nil, handler : @escaping imageDownloaderHandler) {
        self.handler    =   handler
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.handler?(cachedImage, nil)
        }else {
            let operation = BlockOperation()
            operation.addExecutionBlock {
                let image = imageDownloader.loadImage(urlString: imageUrl)
                DispatchQueue.main.async {
                    guard let image = image else {
                        return handler(nil, nil)
                    }
                    imageCache.setObject(image, forKey: "\(imageUrl)" as NSString)
                    handler(image,nil)
                }
            }
            imageDownloader.operationQueue.addOperation(operation)
        }
    }
    
    class func loadImage(urlString: String) -> UIImage? {
        var image : UIImage? = nil
        do {
            if let url = URL(string: urlString) {
                let data = try  Data(contentsOf: url)
                image = UIImage(data: data)
            }
        } catch {
            //print(error)
        }
        return image
    }
    
}

