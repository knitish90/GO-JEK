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
        return String(self.prefix(1)).uppercased()
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
