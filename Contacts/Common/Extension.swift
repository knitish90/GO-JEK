//
//  Extension.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var firstChar : String {
        String(self.prefix(1)).uppercased()
    }
    
    func replace(of toReplace : String, with value : String)-> String {
        replacingOccurrences(of: toReplace, with: value)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self
        return formatter
    }
    
}


extension UIImageView {
    func setImage(with imageUrl : String, indexPath : IndexPath? = nil) {
        imageDownloader.downloadImage(imageUrl: imageUrl, indexPath: indexPath) { (image, error) in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIApplication {
    var isTestingEnvEnabled : Bool {
        return (ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil)
    }
}


extension UIViewController {
    func showAlert(_ message: String?){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: { (alertAction) in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension Encodable {
    func encode()  -> Data? {
        let encoder = JSONEncoder()
        let format = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        JSONEncoder().dateEncodingStrategy = .formatted(format.dateFormatter())
        
        var data : Data?
        do {
             data = try encoder.encode(self)
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return data
    }
}

extension UIView {
    func setGradient(with startColor : UIColor, endColor : UIColor) {
        let gradientColor = CAGradientLayer()
        gradientColor.colors = [startColor.cgColor, endColor.cgColor]
        gradientColor.locations = [0.0 , 1.0]
        gradientColor.frame = self.bounds
        self.layer.insertSublayer(gradientColor, at: 0)
    }
}


