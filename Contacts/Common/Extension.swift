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

