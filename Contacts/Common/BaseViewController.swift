//
//  BaseViewController.swift
//  Contacts
//
//  Created by Nitish.kumar on 27/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, StoryboardProtocol {
     override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
    
    func configureUI() {
        
    }

}
