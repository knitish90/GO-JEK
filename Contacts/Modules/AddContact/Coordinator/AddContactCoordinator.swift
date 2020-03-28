//
//  AddContactCoordinator.swift
//  Contacts
//
//  Created by Nitish.kumar on 28/03/20.
//  Copyright © 2020 Nitish.kumar. All rights reserved.
//

import Foundation
import UIKit

protocol AddCoordinatorProtocol: class {
    func navigateToPreviousPage()
    
}

class AddContactsCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController:UINavigationController?
    
    weak var delegate : AddCoordinatorProtocol?
    
    required init(navigationController: UINavigationController) {
        self.navigationController   =   navigationController
    }
    
    func start() {
        let controller = AddContactViewController.instance()
        controller.delegate =   self
        self.navigationController?.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}

extension AddContactsCoordinator :  AddCoordinatorProtocol {
    func navigateToPreviousPage() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.childCoordinators.removeLast()
        })
    }
}
