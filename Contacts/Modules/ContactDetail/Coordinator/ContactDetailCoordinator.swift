//
//  ContactDetailCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController : UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = ContactDetailViewController.instance()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
